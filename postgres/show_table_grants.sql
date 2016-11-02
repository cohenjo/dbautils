select usename, nspname || '.' || relname as relation,
       case relkind when 'r' then 'TABLE' when 'v' then 'VIEW' end as relation_type,
       priv
from pg_class join pg_namespace on pg_namespace.oid = pg_class.relnamespace,
     pg_user,
     (values('SELECT', 1),('INSERT', 2),('UPDATE', 3),('DELETE', 4)) privs(priv, privorder)
where relkind in ('r', 'v')
      and has_table_privilege(pg_user.usesysid, pg_class.oid, priv)
      and not (nspname ~ '^pg_' or nspname = 'information_schema')
order by 2, 1, 3, privorder;