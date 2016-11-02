
use admin
var list = db.runCommand( { listDatabases: 1 } )
list.databases.forEach(function(dbdoc){
        if(dbdoc.empty != true){
                var d = db.getSisterDB(dbdoc.name);
                d.setSlaveOk(); // you only need this if you run off the replica.
                var col = d.Audit.find({component:"ems", $or: [ { "userId ": { $exists: false } },{ "userId ": null } ]}).count();
                print("number of empty user ids in " + dbdoc.name  + " is: " + col);

        }
    }
);
