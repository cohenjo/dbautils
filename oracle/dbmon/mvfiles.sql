set lines 199
set pages 0
define TOFILESYS = &1
select 'mv -i '||file_name||' '||'/doravl&TOFILESYS/'||substr(file_name,11,length(file_name)-10) from 
(select file_name from dba_data_files
union
select name from v$controlfile
union
select member from v$logfile)
where substr(file_name,1,9)<>'/doravl&TOFILESYS'
/

select 'alter database rename file '''||file_name||''' to ''/doravl&TOFILESYS/'||substr(file_name,11,length(file_name)-10)||''';' from 
(select file_name from dba_data_files
union
select member from v$logfile)
where substr(file_name,1,9)<>'/doravl&TOFILESYS'
/
