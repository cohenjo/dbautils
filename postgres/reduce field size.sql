
Hi,
This is related to IM00121321 that Whitlock but this one is specifically to get 3 requests updated so that they are able to close them. The Email field in each contain almost 1 million characters and they get an error when attempting to save.  We need to truncate the EmailHist_c field so that the entity will once again save.  If you open each and try to save you will see the error.  We have permission to truncate the fields down so that the Requests can be saved.

Production Tenant is:
https://msast001pngx.saas.hp.com/?TENANTID=330053097

 

Requests are:

27978 NNM AnalyzerManager tuning

28148 NNMi showing minor health alert.  NPS dashboards not working.

28760 Sitescope slowness

 

 

 

 

select physical_type_name,logical_type_name from entitydescriptor_mapping where tenant_ID in ('v4','330053097') AND entity_type = 'Request' AND logical_type_name = 'EmailHist_c';
 physical_type_name | logical_type_name
--------------------+-------------------
 12                 | EmailHist_c

 

select * from long_text_100000002 where field_id = 3000 AND is_deleted = false;

select 
entity_id,length(content)
--, left(content, (length(content)*0.8)::int) truncated
,length(left(content, (length(content)*0.8)::int)) trunc_len  from long_text_330053097 where field_id = 12 AND is_deleted = false AND entity_id in (27978,28148,28760);

 update long_text_330053097
 set content = left(content, (length(content)*0.8)::int) 
 where field_id = 12 AND is_deleted = false AND entity_id in (27978,28148,28760);
 
 saas_ast_production_ems=>  update long_text_330053097
saas_ast_production_ems->  set content = left(content, (length(content)*0.8)::int)
saas_ast_production_ems->  where field_id = 12 AND is_deleted = false AND entity_id in (27978,28148,28760);
UPDATE 3
saas_ast_production_ems=> select
entity_id,length(content)
--, left(content, (length(content)*0.8)::int) truncated
,length(left(content, (length(content)*0.8)::int)) trunc_len  from long_text_330053097 where field_id = 12 AND is_deleted = false AND entity_id in (27978,28148,28760);
 entity_id | length | trunc_len
-----------+--------+-----------
     27978 | 644639 |    515711
     28148 | 537437 |    429950
     28760 | 680466 |    544373
(3 rows)
