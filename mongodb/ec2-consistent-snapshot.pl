#!/usr/bin/env perl
#
# Copyright (C) 2009-2014 Eric Hammond <ehammond@thinksome.com>
# Origin can be found at: https://github.com/alestic/ec2-consistent-snapshot
#
use strict;
use warnings;
(our $Prog) = ($0 =~ m%([^/]+)$%);
use Getopt::Long;
use Pod::Usage;
use File::Basename qw(basename);
use File::Slurp;
use IO::Dir;
use IO::Socket::SSL;
use LWP::UserAgent qw();
eval 'use Mozilla::CA';
use Time::HiRes qw(ualarm usleep);
use Net::Amazon::EC2 0.11;
use POSIX ':signal_h';
use DateTime::Locale;
use DateTime::TimeZone;

#---- OPTIONS ----

my $Help                       = 0;
my $Debug                      = 0;
my $Quiet                      = 0;
my $Noaction                   = 0;

my $aws_access_key_id          = $ENV{AWS_ACCESS_KEY_ID};
my $aws_secret_access_key      = $ENV{AWS_SECRET_ACCESS_KEY};
my $aws_access_key_id_file     = $ENV{AWS_ACCESS_KEY_ID};
my $aws_secret_access_key_file = $ENV{AWS_SECRET_ACCESS_KEY};
my $aws_credentials_file       = $ENV{AWS_CREDENTIALS};
my $use_iam_role               = 0;
my $region                     = undef;
my $signature_version          = undef;
my $ec2_endpoint               = undef;
my @descriptions               = ();
my @tags                       = ();
my $tag_separator              = ";";
my @freeze_filesystem          = ();
my @no_freeze_filesystem       = ();
my $mongo                      = 0;
my $mongo_username             = undef;
my $mongo_password             = undef;
my $mongo_host                 = undef;
my $mongo_port                 = 27017;
my $mongo_stop                 = 0;
my $mongo_timeout              = 30000;
my $mysql                      = 0;
#my $mysql_defaults_file        = "$ENV{HOME}/.my.cnf";
my $mysql_defaults_file        = undef;
my $mysql_socket               = undef;
my $mysql_master_status_file   = undef;
my $mysql_username             = undef;
my $mysql_password             = undef;
my $mysql_host                 = undef;
my $mysql_stop                 = 0;
my $percona                    = 0;
my $snapshot_timeout           = 10.0; # seconds
my $lock_timeout               =  0.5; # seconds
my $lock_tries                 = 60;
my $lock_sleep                 =  5.0; # seconds
my $pre_freeze_command         = undef;
my $post_thaw_command          = undef;
my $mongo_init_script                = '/etc/init.d/mongod';

Getopt::Long::config('no_ignore_case');
GetOptions(
  'help|h|?'                     => \$Help,
  'debug|d'                      => \$Debug,
  'quiet|q'                      => \$Quiet,
  'noaction|n'                   => \$Noaction,

  'aws-access-key-id=s'          => \$aws_access_key_id,
  'aws-secret-access-key=s'      => \$aws_secret_access_key,
  'aws-access-key-id-file=s'     => \$aws_access_key_id_file,
  'aws-secret-access-key-file=s' => \$aws_secret_access_key_file,
  'aws-credentials-file=s'       => \$aws_credentials_file,
  'use-iam-role'                 => \$use_iam_role,
  'region=s'                     => \$region,
  'signature-version=s'          => \$signature_version,
  'ec2-endpoint=s'               => \$ec2_endpoint,
  'description=s'                => \@descriptions,
  'tag=s'                        => \@tags,
  'xfs-filesystem=s'             => \@freeze_filesystem,
  'freeze-filesystem=s'          => \@freeze_filesystem,
  'no-freeze-filesystem=s'       => \@no_freeze_filesystem,
  'mongo'                        => \$mongo,
  'mongo-username=s'             => \$mongo_username,
  'mongo-password=s'             => \$mongo_password,
  'mongo-host=s'                 => \$mongo_host,
  'mongo-port=s'                 => \$mongo_port,
  'mongo-stop'                   => \$mongo_stop,
  'mongo-timeout=i'              => \$mongo_timeout,
  'mysql'                        => \$mysql,
  'mysql-defaults-file=s'        => \$mysql_defaults_file,
  'mysql-socket=s'               => \$mysql_socket,
  'mysql-master-status-file=s'   => \$mysql_master_status_file,
  'mysql-username=s'             => \$mysql_username,
  'mysql-password=s'             => \$mysql_password,
  'mysql-host=s'                 => \$mysql_host,
  'mysql-stop'                   => \$mysql_stop,
  'percona'                      => \$percona,
  'snapshot-timeout=s'           => \$snapshot_timeout,
  'lock-timeout=s'               => \$lock_timeout,
  'lock-tries=s'                 => \$lock_tries,
  'lock-sleep=s'                 => \$lock_sleep,
  'pre-freeze-command=s'         => \$pre_freeze_command,
  'post-thaw-command=s'          => \$post_thaw_command,
  'mongo-init=s'                       => \$mongo_init_script,
) or pod2usage(2);

my $filesystem_frozen = 0;

pod2usage(1) if $Help;

my @volume_ids = @ARGV;

$ec2_endpoint ||= "https://ec2.$region.amazonaws.com" if $region;

my $freeze_cmd = _get_fsfreeze();

$mysql = 1 if $percona; # Percona is a variant of MySQL
die "$Prog: ERROR: The --percona and --mysql-master-status-file options are mutually exclusive. ",
                  "Percona locking does not give accurate binlog location."
  if $percona and defined($mysql_master_status_file);

#---- MAIN ----

($aws_access_key_id,      $aws_secret_access_key) = determine_access_keys(
 $aws_access_key_id,      $aws_secret_access_key,
 $aws_access_key_id_file, $aws_secret_access_key_file,
 $aws_credentials_file,
);
die "$Prog: ERROR: Can't find AWS access key or secret access key"
  unless $use_iam_role or ($aws_access_key_id and $aws_secret_access_key);
if ( $Debug && $use_iam_role ) {
    warn "$Prog: Authenticating with IAM role\n";
}
elsif ( $Debug ) {
    warn "$Prog: Using AWS access key: $aws_access_key_id\n";
}


if ( scalar (@volume_ids) == 0 ) {
  @volume_ids = discover_volume_ids($ec2_endpoint);
}
pod2usage(2) unless scalar @volume_ids;

die "$Prog: ERROR: Descriptions count (", scalar (@descriptions),
    ") does not match volumes count (", scalar (@volume_ids), ")"
  if (scalar (@descriptions) > 1 &&
      scalar (@descriptions) != scalar (@volume_ids) );

if ( scalar (@descriptions) == 0 ) {
  $Debug and warn "$Prog: Using default snapshot description\n";
  $descriptions[0] = $Prog;
}

if ( scalar (@descriptions) == 1 ) {
  $Debug and warn "$Prog: Using description '$descriptions[0]'"
                . " for all snapshot descriptions\n";
  for ( my $index = 1; $index < scalar (@volume_ids); ++$index ) {
    $descriptions[$index] = $descriptions[0];
  }
}

die "$Prog: ERROR: Tags count (", scalar (@tags),
    ") does not match volumes count (", scalar (@volume_ids), ")"
  if (scalar (@tags) > 1 &&
      scalar (@tags) != scalar (@volume_ids) );

if ( scalar (@tags) == 1 ) {
  $Debug and warn "$Prog: Using tag '$tags[0]'"
                . " for all snapshot tags\n";
  for ( my $index = 1; $index < scalar (@volume_ids); ++$index ) {
    $tags[$index] = $tags[0];
  }
}

#
# Mongo
#
my $mongo_stopped = undef;
my $mongo_dbh = undef;
if ( $mongo_stop ) {
  $mongo_stopped = mongo_stop();
} elsif ( $mongo ) {
  $mongo_dbh = mongo_connect($mongo_host, $mongo_port, $mongo_username, $mongo_password, $mongo_timeout);
  mongo_lock($mongo_dbh);
}

#
# MySQL
#
my $mysql_stopped = undef;
my $mysql_dbh = undef;
my $mysql_kill_query = 0;
if ( $mysql_stop ) {
  $mysql_stopped = mysql_stop();
} elsif ( $mysql ) {
  $mysql_dbh = mysql_connect($mysql_host, $mysql_socket, $mysql_username, $mysql_password);
  sub interrupt { $mysql_kill_query = 1; die("interrupted") };
  $SIG{INT}    = \&interrupt;
  $SIG{TERM}   = \&interrupt;
  $SIG{HUP}    = \&interrupt;
  mysql_lock($mysql_dbh);
}

if ( $pre_freeze_command ) {
  run_command([$pre_freeze_command]);
}

# sync may help flush changed blocks, increasing the consistency on
# un-freezable filesystems, and reducing the time the freeze locks changes
# out on freezable filesystems.
run_command(['sync']);

if ( scalar @freeze_filesystem > 0 ) {
  fs_freeze($freeze_cmd, \@freeze_filesystem);
  $filesystem_frozen = 1;
}

my $success =
  ebs_snapshot(\@volume_ids, $ec2_endpoint, \@descriptions, \@tags);

exit ($success ? 0 : -1);

END {
  my $exit_status = $?;

  fs_thaw(\@freeze_filesystem) if $filesystem_frozen;

  if ( $post_thaw_command ) {
    run_command([$post_thaw_command]);
  }

  if ( defined($mysql_master_status_file) ) {
    $Debug and warn "$Prog: ", scalar localtime,
      ": removing master info file: $mysql_master_status_file\n";
    if ( not $Noaction ) {
      unlink $mysql_master_status_file
        or die "$Prog: Couldn't remove file: $mysql_master_status_file: $!\n";
    }
  }

  if ( $mongo_stopped ) {
    mongo_start();
  } elsif ( $mongo_dbh ) {
    mongo_unlock($mongo_dbh);
    # We don't need to disconnect with the MongoDB module
  }

  if ( $mysql_stopped ) {
    mysql_start();
  } elsif ( $mysql_dbh ) {
    if ( $mysql_kill_query ) {
       sql_kill_current_query();
    }
    mysql_unlock($mysql_dbh);
    $Debug and warn "$Prog: ", scalar localtime, ": MySQL disconnect\n";
    $mysql_dbh->disconnect;
  }

  $Debug and warn "$Prog: ", scalar localtime, ": done\n";

  exit ($exit_status || $?);
}

#---- METHODS ----

sub ec2_connection {
  my ($ec2_endpoint) = @_;

  $Debug and warn "$Prog: ", scalar localtime, ": create EC2 object\n";
  $Debug and warn "$Prog: Endpoint: $ec2_endpoint\n" if $ec2_endpoint;

  # EC2 API object
  return Net::Amazon::EC2->new(
    ((! $use_iam_role) ? (AWSAccessKeyId  => $aws_access_key_id,) : () ),
    ((! $use_iam_role) ? (SecretAccessKey => $aws_secret_access_key) : () ),
    ($ec2_endpoint ? (base_url => $ec2_endpoint) : ()),
    ($region ? (region => $region) : ()),
    ($signature_version ? (signature_version => $signature_version) : ()),
    # ($Debug ? (debug => 1) : ()),
  );
}

sub ebs_snapshot {
  my ($volume_ids, $ec2_endpoint, $descriptions, $tags) = @_;

  # EC2 API object
  my $ec2 = ec2_connection($ec2_endpoint);

  if ( not $ec2 ) {
    warn "$Prog: ERROR: Unable to create EC2 connection";
    return undef;
  }

 VOLUME:
  for (my $index = 0; $index < scalar(@$volume_ids); ++$index ) {
    my $volume_id = $$volume_ids[$index];
    my $description = $$descriptions[$index];

    $Debug and warn "$Prog: volume_id: $volume_id; description: $description\n";

    # Snapshot
    $Debug and
      warn "$Prog: ", scalar localtime, ": aws ec2 create-snapshot $volume_id\n";

    my $snapshot;
    if ( !$Noaction ) {
    	eval {
    	  local $SIG{ALRM} = sub { ualarm(0); die "timeout\n" };
    	  ualarm($snapshot_timeout * 1_000_000);
    	  $snapshot = $ec2->create_snapshot(
    	    VolumeId    => $volume_id,
    	    Description => $description,
    	  );
    	  ualarm(0);
    	};
    	ualarm(0);
    	if ( $@  ){
    	  warn "$Prog: ERROR: create_snapshot: ", ec2_error_message($@);
    	  return undef;
    	}
    }
    else {
      my $snapshot_tag = $tags[$index] || "None.";
      warn "snapshot SKIPPED volume_id: $volume_id; description: $description; tags: $snapshot_tag (--noaction)\n";
      next VOLUME;
    }

    my $snapshot_id;
    if ( not defined $snapshot ) {
      warn "$Prog: ERROR: create_snapshot returned undef\n";
      return undef;
    } elsif ( not ref $snapshot ) {
      warn "$Prog: ERROR: create_snapshot returned '$snapshot'\n";
      return undef;
    } elsif ( $snapshot->can('snapshot_id') ) {
      $snapshot_id = $snapshot->snapshot_id;
      my $snapshot_tag = _get_snapshot_tags(\@tags,$index);
      if (keys %$snapshot_tag){
        $ec2->create_tags(
            ResourceId    => $snapshot_id,
            Tags          => $snapshot_tag,
        );
      }
      $Quiet or print "$snapshot_id\n";
    } else {
      for my $error ( @{$snapshot->errors} ) {
        warn "$Prog: ERROR: ".$error->message."\n";
      }
      return undef;
    }
  }
  return 1;
}

# Given array of tags and an index, parse them and return tags for a specific volumme
sub _get_snapshot_tags {
   my ($tags,$index) = @_;
   my %snapshot_tag;
   if (scalar @$tags > 0){
     my $tag = $tags->[$index];
     my @sep_tags = split($tag_separator, $tag);
     if(scalar (@sep_tags) > 0){
       for ( my $tag_index = 0; $tag_index < scalar (@sep_tags); ++$tag_index ) {
         my ($tag_key, $tag_value) = split('=', $sep_tags[$tag_index], 2);
         $snapshot_tag{$tag_key} = $tag_value;
       }
     }
   }
   return \%snapshot_tag;
}

sub get {
  my ($url) = @_;

  my $ua = LWP::UserAgent->new;
  $ua->timeout(2);

  my $response = $ua->get($url);

  my $content;
  if ($response->is_success) {
    $content = $response->decoded_content;
  } else {
    $Debug and warn "$Prog: ", scalar localtime,
                    ": Unable to fetch $url: @{[$response->status_line]}\n";
  }

  return $content;
}

sub ec2_instance_description {
  my ($ec2_endpoint) = @_;

  $Debug and warn "$Prog: ", scalar localtime,
                  ": Determining instance id\n";

  my $instance_id = get('http://169.254.169.254/latest/meta-data/instance-id');
  unless ( defined $instance_id ) {
    warn "$Prog: ERROR: Unable to determine instance id\n";
    return undef;
  }

  my $ec2 = ec2_connection($ec2_endpoint);

  $Debug and warn "$Prog: ", scalar localtime,
                  ": Fetching instance description for $instance_id\n";
  my $reservations = $ec2->describe_instances(InstanceId => $instance_id);
  unless ( defined($reservations) && scalar(@$reservations) == 1 ) {
    warn "$Prog: ERROR: Unable to find reservation for $instance_id\n";
    return undef;
  }

  return $reservations->[0]->instances_set->[0];
}

sub discover_volume_ids {
  my ($ec2_endpoint) = @_;

  $Debug and warn "$Prog: ", scalar localtime,
                  ": No volume ids specified; discovering volume ids\n";

  my @filesystems = (@freeze_filesystem, @no_freeze_filesystem);

  if ( scalar(@filesystems) == 0 ) {
    $Debug and warn "$Prog: ", scalar localtime,
                    ": No filesystems specified; unable to discover volume ids\n";
    return ();
  }

  $Debug and warn "$Prog: ", scalar localtime,
                  ": Discovering volume ids for: @filesystems\n";

  my $ec2_instance = ec2_instance_description($ec2_endpoint);
  return () unless $ec2_instance;

  # RunningInstances->block_device_mapping is a Maybe[ArrayRef]
  unless ( $ec2_instance->block_device_mapping ) {
    warn "$Prog: ERROR: Unable to find block device mappings for ", $ec2_instance->instance_id, "\n";
    return ();
  }

  my %ebs_volume_ids = ();
  for my $bd ( @{$ec2_instance->block_device_mapping} ) {
    # BlockDeviceMapping->ebs is a Maybe[ArrayRef]
    $ebs_volume_ids{$bd->device_name} = $bd->ebs->volume_id if $bd->ebs;
  }

  unless ( %ebs_volume_ids ) {
    warn "$Prog: ERROR: Unable to find EBS block devices for ", $ec2_instance->instance_id, "\n";
    return ();
  }

  if ( $Debug ) {
    warn "$Prog: ", scalar localtime,
         ": Found EBS block devices for ", $ec2_instance->instance_id, ": \n";
    for my $dev (sort keys %ebs_volume_ids) {
      warn "$Prog: ", scalar localtime, ":     ", $ebs_volume_ids{$dev}, " ", $dev, "\n";
    }
  }

  my $volume_ids;
  for my $fs (@filesystems) {
    my $device = qx(mountpoint -dq "$fs");
    chomp $device;
    unless ($? == 0 && $device) {
      warn "$Prog: ERROR: $fs is not a mount point\n";
      return ();
    }

    # Check sysfs for a /slaves directory; if we find one, assume we have a
    # compound device (e.g. LVM or Raid), otherwise, get the basename of the
    # symlink at /sys/dev/block/MAJOR:MINOR
    my $slaves = IO::Dir->new("/sys/dev/block/$device/slaves");
    my @devices = ();
    push @devices, grep { !/^\./ } $slaves->read() if defined($slaves);
    push @devices, basename readlink("/sys/dev/block/$device") unless scalar(@devices);

    if ( scalar(@devices) == 0 ) {
      warn "$Prog: ERROR: Unable to determine devices for mount $fs\n";
      return ();
    }

    for my $device (@devices) {
      my $ec2_device = "/dev/$device";
      $ec2_device =~ s/\bxvd/sd/;

      my $volume_id = $ebs_volume_ids{$ec2_device};

      unless ( defined $volume_id ) {
        warn "$Prog: ERROR: Unable to determine volume id for device $device in mount $fs\n";
        return ();
      }

      push @$volume_ids, $volume_id;
    }
  }

  return @$volume_ids;
}

#
# Mongo
#
sub mongo_connect {
  my ($mongo_host, $mongo_port, $mongo_username, $mongo_password, $mongo_timeout) = @_;

  require MongoDB;
  MongoDB->import;
  require MongoDB::Database;
  MongoDB::Database->import;

  $mongo_host ||= 'localhost';

  $Debug and warn "$Prog: ", scalar localtime,
                  ": mongo connect on ${mongo_host}:${mongo_port}\n";

  my $mongo_conn = MongoDB::MongoClient->new(host => "${mongo_host}:${mongo_port}", query_timeout => $mongo_timeout)
    or die "$Prog: ERROR: Unable to connect to mongo"
         . " on $mongo_host";

  if (defined $mongo_username && defined $mongo_password) {
    $mongo_conn->authenticate('admin', $mongo_username, $mongo_password)
      or die "$Prog: ERROR: Unable to connect to mongo"
           . " on $mongo_host as $mongo_username";
  }

  return $mongo_conn;
}

sub mongo_lock {
  my ($mongo_dbh) = @_;

  # Don't worry about retry since Mongo has reconnect option on by default
  $Debug and warn "$Prog: ", scalar localtime, ": locking mongo\n";

  if ( $Noaction ) {
    warn "mongo lock SKIPPED (--noaction)\n";
  }
  $mongo_dbh->fsync({lock => 1});

  $Debug and warn "$Prog: ", scalar localtime, ": mongo locked\n";

  return 1;
}

sub mongo_unlock {
  my ($mongo_dbh) = @_;

  # Don't worry about retry since Mongo has reconnect option on by default
  $Debug and warn "$Prog: ", scalar localtime, ": unlocking mongo\n";

  if ( $Noaction ) {
    warn "mongo unlock SKIPPED (--noaction)\n";
  }
  $mongo_dbh->fsync_unlock();

  $Debug and warn "$Prog: ", scalar localtime, ": mongo unlocked\n";

}

sub mongo_stop {
  $Debug and warn "$Prog: ", scalar localtime, ": mongo stop\n";

  my $result = system($mongo_init_script, 'stop');

  if ( $result != 0 ) {
    die "$Prog: Unable to stop mongod: $? $!";
  }

  return 1;
}

sub mongo_start {
  $Debug and warn "$Prog: ", scalar localtime, ": mongo start\n";

  my $result = system($mongo_init_script, 'start');

  if ( $result != 0 ) {
    warn "$Prog: Unable to start mongod: $? $!";
  }
}


#
# MySQL
#
sub mysql_connect {
  my ($mysql_host, $mysql_socket, $mysql_username, $mysql_password) = @_;
  my $dsn_extra = "";

  require DBI;
  DBI->import;

  if ( defined($mysql_defaults_file) )
  {
    ($mysql_host, $mysql_username, $mysql_password, $mysql_socket) = read_mydefaultsfile(
      $mysql_defaults_file,
    );
  } else {
    ($mysql_host, $mysql_username, $mysql_password, $mysql_socket) = read_mycnf(
      $mysql_host, $mysql_username, $mysql_password, $mysql_socket
    );
  }
  if( defined($mysql_socket) ) {
    $dsn_extra .= "mysql_socket=$mysql_socket;";
  }

  $mysql_host ||= 'localhost';

  $Debug and warn "$Prog: ", scalar localtime,
                  ": MySQL connect as $mysql_username\n";

  my $mysql_dbh = DBI->connect("DBI:mysql:;${dsn_extra}host=$mysql_host",
                         $mysql_username, $mysql_password)
    or die "$Prog: ERROR: Unable to connect to MySQL"
         . " on $mysql_host as $mysql_username";

  return $mysql_dbh;
}

sub mysql_lock {
  my ($mysql_dbh) = @_;

  # Don't pass FLUSH TABLES statements on to replication slaves
  # as this can interfere with long-running queries on the slaves.
  $mysql_dbh->do(q{ SET SQL_LOG_BIN=0 }) unless $Noaction;

  if ( $percona ) {
    # http://www.percona.com/blog/2014/03/11/introducing-backup-locks-percona-server-2/
    sql_timeout_retry(
      q{ LOCK TABLES FOR BACKUP },
      "Percona table lock",
      $lock_timeout,
      $lock_tries,
      $lock_sleep,
    );

    $mysql_dbh->do(q{ SET SQL_LOG_BIN=1 }) unless $Noaction;
    return # do not store/print binlog info as can be erroneous

  } else {
    # Try a flush first without locking so the later flush with lock
    # goes faster.  This may not be needed as it seems to interfere with
    # some statements anyway.
    sql_timeout_retry(
      q{ FLUSH LOCAL TABLES },
      "MySQL flush",
      $lock_timeout,
      $lock_tries,
      $lock_sleep,
    );

    # Get a lock on the entire database
    sql_timeout_retry(
      q{ FLUSH LOCAL TABLES WITH READ LOCK },
      "MySQL flush & lock",
      $lock_timeout,
      $lock_tries,
      $lock_sleep,
    );
  }

  my ($mysql_logfile, $mysql_position,
      $mysql_binlog_do_db, $mysql_binlog_ignore_db);
  if ( not $Noaction ) {
    # This might be a slave database already
    my $slave_status = $mysql_dbh->selectrow_hashref(q{ SHOW SLAVE STATUS });
    $mysql_logfile           = $slave_status->{Slave_IO_State}
                             ? $slave_status->{Master_Log_File}
                             : undef;
    $mysql_position          = $slave_status->{Read_Master_Log_Pos};
    $mysql_binlog_do_db      = $slave_status->{Replicate_Do_DB};
    $mysql_binlog_ignore_db  = $slave_status->{Replicate_Ignore_DB};

    # or this might be the master
    ($mysql_logfile, $mysql_position,
     $mysql_binlog_do_db, $mysql_binlog_ignore_db) =
      $mysql_dbh->selectrow_array(q{  SHOW MASTER STATUS  })
      unless $mysql_logfile;
  }

  $mysql_dbh->do(q{ SET SQL_LOG_BIN=1 }) unless $Noaction;

  print "$Prog: master_log_file=\"$mysql_logfile\",",
              " master_log_pos=$mysql_position\n"
    if $mysql_logfile and not $Quiet;

  if ( defined($mysql_master_status_file) && $mysql_logfile ) {
    $Debug and warn "$Prog: ", scalar localtime,
      ": writing MASTER STATUS to $mysql_master_status_file\n";
    if ( not $Noaction ) {
      open(MYSQLMASTERSTATUS,"> $mysql_master_status_file") or
        die "$Prog: Unable to open for write: $mysql_master_status_file: $!\n";
      print MYSQLMASTERSTATUS <<"EOM";
master_log_file="$mysql_logfile"
master_log_pos="$mysql_position"
master_binlog_do_db="$mysql_binlog_do_db"
master_binlog_ignore_db="$mysql_binlog_ignore_db"
EOM
      close(MYSQLMASTERSTATUS);
    }
  }
}

sub mysql_unlock {
  my ($mysql_dbh) = @_;

  $Debug and warn "$Prog: ", scalar localtime, ": MySQL unlock\n";
  $mysql_dbh->do(q{ UNLOCK TABLES }) unless $Noaction;

}

sub mysql_stop {
  $Debug and warn "$Prog: ", scalar localtime, ": MySQL stop\n";

  my $result = system('/usr/bin/mysqladmin', 'shutdown');

  if ( $result != 0 ) {
    die "$Prog: Unable to stop mysqld: $? $!";
  }

  return 1;
}

sub mysql_start {
  $Debug and warn "$Prog: ", scalar localtime, ": MySQL start\n";

  my $result = system('/etc/init.d/mysql', 'start');

  if ( $result != 0 ) {
    warn "$Prog: Unable to start mysqld: $? $!";
  }
}

# See also:
#http://search.cpan.org/dist/DBI/DBI.pm#Signal_Handling_and_Canceling_Operations
sub sql_timeout_retry {
  my ($sql, $description, $lock_timeout, $lock_tries, $lock_sleep) = @_;

  my $action = POSIX::SigAction->new(
    sub { $mysql_kill_query = 1; die "timeout"; },
    POSIX::SigSet->new( SIGALRM ),
  );
  my $oldaction = POSIX::SigAction->new();
  sigaction(SIGALRM, $action, $oldaction);
 LOCK:
  while ( $lock_tries -- ) {
    $Debug and warn "$Prog: ", scalar localtime, ": $description\n";
    eval {
      ualarm($lock_timeout * 1_000_000);
      $mysql_dbh->do($sql) unless $Noaction;
      ualarm(0);
    };
    ualarm(0);
    last LOCK unless $@ =~ /timeout/;

    if ( $mysql_kill_query ) {
       sql_kill_current_query();
    }

  } continue {
    die if $@ =~ /interrupted/;

    $Quiet or  warn "$Prog: MySQL timeout at $lock_timeout sec\n";
    $Debug and warn "$Prog: Trying again in $lock_sleep seconds\n";
    usleep($lock_sleep * 1_000_000);
    #TBD: May need to reopen $mysql_dbh here as the handle may not be clean.
  }
  sigaction(SIGALRM, $oldaction);
  die "$Prog: ERROR: MySQL failure: $@" if $@;
}

# Kill current query after timeout or interrupt signal (see issue #23)
sub sql_kill_current_query {
   if ( $mysql_dbh ) {
      $mysql_dbh->clone()->do("KILL QUERY ".$mysql_dbh->{"mysql_thread_id"});
   }
   $mysql_kill_query = 0;
}

sub fs_freeze {
  my ($freeze_cmd, $freeze_filesystem) = @_;

  for my $filesystem ( @$freeze_filesystem ) {
    run_command([$freeze_cmd, '-f', $filesystem]);
  }
}

sub fs_thaw {
  my ($freeze_filesystem) = @_;

  for my $filesystem ( @$freeze_filesystem ) {
    run_command([$freeze_cmd, '-u', $filesystem]);
  }
}

# mysql defaults-file
sub read_mydefaultsfile {
  my ($mysql_defaults_file) = @_;

  open(MYCNF, $mysql_defaults_file)
    or die "$Prog: ERROR: Couldn't open defaults-file $mysql_defaults_file\n";
  while ( defined (my $line = <MYCNF>) ) {
    $mysql_host     = $1 if $line =~ m%^\s*host\s*=\s*"?(\S+?)"?$%
                        and not defined $mysql_host;
    $mysql_username = $1 if $line =~ m%^\s*user\s*=\s*"?(\S+?)"?$%
                        and not defined $mysql_username;
    $mysql_password = $1 if $line =~ m%^\s*password\s*=\s*"?(\S+?)"?$%
                        and not defined $mysql_password;
    $mysql_socket   = $1 if $line =~ m%^\s*socket\s*=\s*"?(\S+?)"?$%
                        and not defined $mysql_socket;
  }
  close(MYCNF);

  return ($mysql_host, $mysql_username, $mysql_password, $mysql_socket);
}

# Look for the MySQL username/password in $HOME/.my.cnf
sub read_mycnf {
  my ($mysql_host, $mysql_username, $mysql_password, $mysql_socket) = @_;

  open(MYCNF, "$ENV{HOME}/.my.cnf")
    or return($mysql_host, $mysql_username, $mysql_password, $mysql_socket);
  while ( defined (my $line = <MYCNF>) ) {
    $mysql_host     = $1 if $line =~ m%^\s*host\s*=\s*"?(\S+?)"?$%
                        and not defined $mysql_host;
    $mysql_username = $1 if $line =~ m%^\s*user\s*=\s*"?(\S+?)"?$%
                        and not defined $mysql_username;
    $mysql_password = $1 if $line =~ m%^\s*password\s*=\s*"?(\S+?)"?$%
                        and not defined $mysql_password;
    $mysql_socket   = $1 if $line =~ m%^\s*socket\s*=\s*"?(\S+?)"?$%
                        and not defined $mysql_socket;
  }
  close(MYCNF);

  return ($mysql_host, $mysql_username, $mysql_password, $mysql_socket);
}


# Figure out which AWS credentials to use
sub determine_access_keys {
  my ($aws_access_key_id,      $aws_secret_access_key,
      $aws_access_key_id_file, $aws_secret_access_key_file,
      $aws_credentials_file,
     ) = @_;

  # 1. --aws-access-key-id and --aws-secret-access-key
  return ($aws_access_key_id, $aws_secret_access_key)
    if $aws_access_key_id;

  # 2. --aws-access-key-id-file and --aws-secret-access-key-file
  if ( $aws_access_key_id_file ) {
    die "$Prog: Please provide both --aws-access-key-id-file and --aws-secret-access-key-file"
      unless $aws_secret_access_key_file;
    $aws_access_key_id    = File::Slurp::read_file($aws_access_key_id_file);
    $aws_secret_access_key= File::Slurp::read_file($aws_secret_access_key_file);
    chomp($aws_access_key_id);
    chomp($aws_secret_access_key);
    return ($aws_access_key_id, $aws_secret_access_key);
  }

  # 3. $AWS_CREDENTIALS or $HOME/.awssecret
  return read_awssecret($aws_credentials_file);
}


# Look for the access keys in $AWS_CREDENTIALS or ~/.awssecret
sub read_awssecret {
  my ($aws_credentials_file) = @_;
      $aws_credentials_file  ||= "$ENV{HOME}/.awssecret";
  my ($aws_access_key_id, $aws_secret_access_key);
  eval {
    ($aws_access_key_id, $aws_secret_access_key) =
      File::Slurp::read_file($aws_credentials_file);
    chomp $aws_access_key_id;
    chomp $aws_secret_access_key;
  };
  return ($aws_access_key_id, $aws_secret_access_key);
}

# Run a system command, warning if there are problems.
# Pass in reference to an array of command args.
sub run_command {
  my ($command) = @_;

  $Debug and warn "$Prog: ", scalar localtime, ": @$command\n";
  return if $Noaction;
  eval {
    system(@$command) and die "failed($?)\n";
  };
  warn "$Prog: ERROR: @$command: $@" if $@;
}


# Support error formats from different versions of Net::Amazon::EC2
sub ec2_error_message {
    my ($error) = @_;

    if ( ref $error && ref $error->errors eq 'ARRAY' ) {
        $error = join("\n", map {$_->code.': '.$_->message} @{$error->errors});
    }

    return $error;
}

# If fsfreeze is not in $PATH, try some paths which are usually excluded from the cron $PATH before
# falling back to xfs_freeze
sub _get_fsfreeze {
  my $freeze_cmd = "fsfreeze";

  my $freeze_not_in_path = (system("which $freeze_cmd >/dev/null") != 0);
  if ($freeze_not_in_path) {
    if (-x '/usr/sbin/fsfreeze')  {
      $freeze_cmd = '/usr/sbin/fsfreeze';
    }
    elsif (-x '/sbin/fsfreeze') {
      $freeze_cmd = '/sbin/fsfreeze';
    }
    else {
      $freeze_cmd    = "xfs_freeze";
    }
  }
  return $freeze_cmd;
}



=head1 NAME

ec2-consistent-snapshot - Create EBS snapshots on EC2 w/consistent filesystem/db

=head1 SYNOPSIS

 ec2-consistent-snapshot [opts] VOLUMEID...

=head1 OPTIONS

=over

=item -h --help

Print help and exit.

=item -d --debug

Debug mode.

=item -q --quiet

Quiet mode.

=item -n --noaction

Dry run. Just say what you would have done, don't do it.

=item --aws-access-key-id KEY

=item --aws-secret-access-key SECRET

Amazon AWS access key and secret access key.  Defaults to
environment variables or .awssecret file contents described below.

=item --aws-access-key-id-file KEYFILE

=item --aws-secret-access-key-file SECRETFILE

Files containing Amazon AWS access key and secret access key.
Defaults to environment variables or .awssecret file contents
described below.

=item  --aws-credentials-file CREDENTIALSFILE

File containing both the Amazon AWS access key and secret access
key on seprate lines and in that order.  Defaults to contents of
$AWS_CREDENTIALS environment variable or the value $HOME/.awssecret

=item  --use-iam-role

The instance is part of an IAM role that that has permission to create
snapshots so there is no need to specify access key or secret. See L</IAM ROLES>
section for an example Managed Policy with the required permissions.

=item --region REGION

Specify a different EC2 region like "eu-west-1".  Defaults to
"us-east-1".

=item --description DESCRIPTION

Specify a description string for the EBS snapshot.  Defaults to the
name of the program.

You may specify this option multiple times if you need to customize
descriptions of multiple volumes snapshots. If specified multiple
times descriptions count has to match volumes count and they will be
applied on the same order.

=item --tag "KEY=VALUE;KEY2=VALUE2"

If the --tag option is given once, the provided tags will be applied to all
created snapshots.  Tag keys and values must be separated by '='. Multiple tags
must be separated by ';'.

If the --tag option is provided more than once, the tags for each use of --tag
will apply to each volume in the order that the volumes are provided.

To check how your tags will be applied, you can use the --noaction flag before
actually running a snapshot.

=item  --freeze-filesystem MOUNTPOINT

=item --xfs-filesystem MOUNTPOINT [OBSOLESCENT form of the same option]

Indicates that the filesystem at the specified mount point should be
flushed and frozen during the snapshot. Requires the xfs_freeze or
fsfreeze program. Note that xfs_freeze is equivalent to fsfreeze and
works on any filesystems that support freezing, provided the kernel
you are using supports it. (Linux Ext3/4, ReiserFS, JFS, XFS.)
fsfreeze comes with newer versions of util-linux.

You may specify this option multiple times if you need to freeze multiple
filesystems on the the EBS volume(s).

If no EBS volume ids are specified as command arguments, the specified
mountpoints will be used along with mount points passed to
--no-freeze-filesystem to determine the volume ids.

=item --no-freeze-filesystem MOUNTPOINT

Indicates that the filesystem at the specified mount point should be used for
volume id discovery if no volume ids are specified as arguments, but that it
should not be frozen.

You may specify this options multiple times if you need to discover EBS volumes
for multiple filesystems.

=item --mongo

Indicates that the volume contains data files for a running Mongo
database, which will be flushed and locked during the snapshot.

=item --mongo-host HOST

Define host used with the `--mongo` option.

Defaults to 'localhost'.

=item --mongo-port PORT

Define MongoDB port used with the `--mongo` option.

Defaults to 27017

=item --mongo-username USER

Define MongoDB username used with the `--mongo` option.

Defaults to `undef`. Required only if authentication is required.

=item --mongo-password PASS

Define MongoDB password used with the `--mongo` option.

Defaults to `undef`.  Required only if authentication is required.

=item --mongo-stop

Indicates that the volume contains data files for a running Mongo
instance.  The instance is shutdown before the snapshot is initiated
and restarted afterwards. [EXPERIMENTAL]

Uses the `--mongo-init` option to stop and start the database ignores
all other Mongo-related options

=item --mongo-init

The command used to stop and start mongo.

Defaults to `/etc/init.d/mongod`.

Used only if `--mongo-stop` is used. The `--mongo-init` command is passed the 'stop' and 'start'
options during to the stop/start process.

=item --mysql

Indicates that the volume contains data files for a running MySQL
database, which will be flushed and locked during the snapshot.

To connect, we will first look in `--mysql-defaults-file`, if provided.
Otherwise, the values of `--mysql-host`, `--mysql-socket`, `--mysql-username`
and `--mysql-password` will be used to build the connection string.


=item --mysql-defaults-file FILE

MySQL defaults file, containing host, username and password, this
option will ignore the --mysql-host, --mysql-username,
--mysql-password parameters

=item --mysql-host HOST

=item --mysql-socket PATH

=item --mysql-username USER

=item --mysql-password PASS

MySQL host, socket path, username, and password used to flush logs and
lock tables.  User must have appropriate permissions.  Defaults to
$HOME/.my.cnf file contents.

=item --mysql-master-status-file FILE

Store the MASTER STATUS output in a file on the snapshot. It will be
removed after the EBS snapshot is taken.  This option will be ignored
with --mysql-stop

=item --mysql-stop

Indicates that the volume contains data files for a running MySQL database.
The database is shutdown using `/usr/bin/mysqladmin stop` before the snapshot
is initiated and restarted afterwards using `/etc/init.d/mysql start`. Suitable
for running as root when a few seconds of downtime are acceptable.
[EXPERIMENTAL]

=item --percona

Indicates that the volume contains data files for a running Percona/MySQL
database, which will be locked using Percona's unique backup locking commands.
Note: this sets '--mysql' automatically.

=item --snapshot-timeout SECONDS

How many seconds to wait for the snapshot-create to return.  Defaults
to 10.0

=item --lock-timeout SECONDS

How many seconds to wait for a database lock. Defaults to 0.5.
Making this too large can force other processes to wait while this
process waits for a lock.  Better to make it small and try lots of
times.

=item --lock-tries COUNT

How many times to try to get a database lock before failing.  Defaults
to 60.

=item --lock-sleep SECONDS

How many seconds to sleep between database lock tries.  Defaults
to 5.0.

=item --pre-freeze-command COMMAND

Command to run after MySQL stop/lock and before filesystem freeze.

=item --post-thaw-command COMMAND

Command to run immediately after filesystem unfreeze and before MySQL
start/unlock.

=back

=head1 ARGUMENTS

=over

=item VOLUMEID

EBS volume id(s) for which a snapshot is to be created.

=back

=head1 DESCRIPTION

This program creates an EBS snapshot for an Amazon EC2 EBS volume.  To
help ensure consistent data in the snapshot, it tries to flush and
freeze the filesystem(s) first as well as flushing and locking the
database, if applicable.

Filesystems can be frozen during the snapshot. Prior to Linux kernel
2.6.29, XFS must be used for freezing support. While frozen, a filesystem
will be consistent on disk and all writes will block.

There are a number of timeouts to reduce the risk of interfering with
the normal database operation while improving the chances of getting a
consistent snapshot.

If you have multiple EBS volumes in a RAID configuration, you can
specify all of the volume ids on the command line and it will create
snapshots for each while the filesystem and database are locked.  Note
that it is your responsibility to keep track of the resulting snapshot
ids and to figure out how to put these back together when you need to
restore the RAID setup.

If you have multiple EBS volumes which are hosting different file
systems, it might be better to simply run the command once for each
volume id.

=head1 EXAMPLES

Snapshot a volume with a frozen filesystem under /vol containing a
MySQL database:

 ec2-consistent-snapshot --mysql --freeze-filesystem /vol vol-VOLUMEID

Snapshot a volume with a frozen filesystem under /data containing a
Mongo database:

 ec2-consistent-snapshot --mongo --freeze-filesystem /data vol-VOLUMEID

Snapshot a volume mounted with a frozen filesystem on /var/local but
with no MySQL database:

 ec2-consistent-snapshot --freeze-filesystem /var/local vol-VOLUMEID

Snapshot four European volumes in a RAID configuration with MySQL,
saving the snapshots with a description marking the current time:

 ec2-consistent-snapshot                                      \
   --mysql                                                    \
   --freeze-filesystem /vol                                   \
   --region eu-west-1                                         \
   --description "RAID snapshot $(date +'%Y-%m-%d %H:%M:%S')" \
   vol-VOL1 vol-VOL2 vol-VOL3 vol-VOL4

Snapshot four us-east-1 volumes in a RAID configuration with Mongo,
saving the snapshots with a description marking the current time:

 ec2-consistent-snapshot                                      \
   --mongo                                                    \
   --freeze-filesystem /data                                  \
   --region us-east-1                                         \
   --description "RAID snapshot $(date +'%Y-%m-%d %H:%M:%S')" \
   vol-VOL1 vol-VOL2 vol-VOL3 vol-VOL4

Snapshot two volumes with customized descriptions:

 ec2-consistent-snapshot                                      \
   --description "Description 1st Volume"                     \
   --description "Description 2nd Volume"                     \
   vol-VOL1 vol-VOL2

Snapshot a volume without specifying a volume id (requires ec2:DescribeInstances
permission):

 ec2-consistent-snapshot --freeze-filesystem /vol

=head1 ENVIRONMENT

=over

=item $AWS_ACCESS_KEY_ID

Default value for access key.
Can be overridden by command line options.

=item $AWS_SECRET_ACCESS_KEY

Default value for secret access key.  Can be overridden by command
line options.

=item $AWS_CREDENTIALS

Default value for filename containing both access key and secret
access key on separate lines and in that order. Can be overriden by
the --aws-credentials command line option.

=back

=head1 FILES

=over

=item $HOME/.my.cnf

Default values for MySQL user and password are sought here in the
standard format.

=item $HOME/.awssecret

Default values for access key and secret access keys are sought here.
Can be overridden by environment variables and command line options.

=back

=head1 INSTALLATION

On most Ubuntu releases, the B<ec2-consistent-snapshot> package can be
installed directly from the Alestic.com PPA using the following
commands:

 sudo add-apt-repository ppa:alestic
 sudo apt-get update
 sudo apt-get install ec2-consistent-snapshot

This program may also require the installation of the Net::Amazon::EC2
Perl package from CPAN.  On Ubuntu 10.04 Lucid and higher, this should
happen automatically by the dependency on the libnet-amazon-ec2-perl
package.

On some earlier releases of Ubuntu you can install the required
package with the following command:

 sudo PERL_MM_USE_DEFAULT=1 cpan Net::Amazon::EC2

On Ubuntu 8.04 Hardy, use the following commands instead:

 code=$(lsb_release -cs)
 echo "deb http://ppa.launchpad.net/alestic/ppa/ubuntu $code main"|
   sudo tee /etc/apt/sources.list.d/alestic-ppa.list
 sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BE09C571
 sudo apt-get update
 sudo apt-get install ec2-consistent-snapshot build-essential
 sudo cpan Net::Amazon::EC2

The default values can be accepted for most of the prompts, though it
is necessary to select a CPAN mirror on Hardy.

=for markdown <a name="iam-roles"></a>

=head1 IAM ROLES

When authenticating using a IAM Role your role must have the appropriate
permissions.  You can create a single IAM Managed Policy that allows the
necessary permissions and attach the managed policy to each IAM role you would
like to allow to create EC2 snapshots.

The following policy allows both creating the snapshots as the read-only
C<DescribeInstances> permission which is required if you want to snapshot a volume
without specifying the volume ID.

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "1",
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateSnapshot",
                    "ec2:CreateTags",
                    "ec2:DescribeInstances"
                ],
                "Resource": [
                    "*"
                ]
            }
        ]
    }

If you get an "unauthorized" error when using the C<--use-iam-role> option, you
can use the C<--debug> option to confirm whether it was the
C<DescribeInstances> or C<CreateSnapshot> API call that failed.

You might also use IAM policies to allow automating deleting old snapshots
through another tool. Using a separate policy is recommended for that. By
putting the "delete" permission in the same policy, you would be allowing
someone with access to one of your EC2 instances to delete the backups of the
instance volumes. Instead, carefully restrict the delete permission.

=head1 VOLUME DISCOVERY

If no EBS volume ids are passed as arguments to ec2-consistent-snapshot, it
will attempt to discover the volume ids based on the mount points passed to
--no-freeze-filesystem and --freeze-filesystem.

In order to determine the volume ids, ec2-consistent-snapshot first makes a
call to the EC2 instance metadata service to determine the instance's id. Next,
it makes a call to the DescribeInstances EC2 api to get the list of volumes
attached to the instance. It then compares the device names for each attachment
with a list of device names determined using mountpoint(1) and sysfs.

=head1 SEE ALSO

=over

=item Amazon EC2

=item Amazon EC2 EBS (Elastic Block Store)

=item L<aws ec2 create-snapshot|http://docs.aws.amazon.com/cli/latest/reference/ec2/create-snapshot.html>

=back

=head1 CAVEATS

Freezing the root filesystem is not recommended. Be sure to test
each filesystem you use it on before putting this into production, in
exactly the way you would run it in production (e.g., inside cron if
that's how you invoke it).

ec2-consistent-snapshot can hang if its output is directed at a
filesystem that is being frozen, leading to a dead machine.

EBS snapshots are a critical part of protecting your valuable data.
This program or the environment in which it is run may contain defects
that cause snapshots to not be created.  Please test and check to make
sure that snapshots are getting created for the volumes as you intend.

EBS snapshots cost money to create and to store in your AWS account.
Be aware of and monitor your expenses.

You are responsible for what happens in your EC2 account.  This
software is intended, but not guaranteed, to help in that effort.

This program tries hard to figure out some values are for the AWS key
and AWS secret access key.  In fact, it tries too hard.  This results
in possibly using some credentials it finds that are not the correct
ones you wish to use, especially if you are operating in an
environment where multiple sets of credentials are in use.

=head1 BUGS

Please report bugs at https://bugs.launchpad.net/ec2-consistent-snapshot

=head1 CREDITS

Thanks to the following for performing tests on early versions,
providing feature development, feedback, bug reports, and patches:

  David Erickson
  Steve Caldwell
  Gryp
  Ken Huang
  Jefferson Noxon
  Bobb Crosbie
  Craig Tracey
  Diego Salvi
  Christian Marquardt
  Todd Roman
  Ben Tucker
  David Rogeres
  Kevin Lewis
  Eric Lubow
  Seth de l'Isle
  Peter Waller
  yalamber
  Daniel Beardsley
  dileep-p
  theonlypippo
  Tobias Lindgren
  nbfowler
  Mark Stosberg
  Tim McEwan

=head1 AUTHOR/MAINTAINER

Eric Hammond <ehammond@thinksome.com>

=head1 LICENSE

Copyright 2009-2015 Eric Hammond <ehammond@thinksome.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut
