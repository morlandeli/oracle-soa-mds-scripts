set serveroutput on;
DECLARE
  MAX_CREATION_DATE TIMESTAMP;
  MIN_CREATION_DATE TIMESTAMP;
  batch_size        INTEGER;
  retention_period  TIMESTAMP;
  purgeable_instance INTEGER;
  table_partitioned INTEGER;
BEGIN
  MAX_CREATION_DATE := to_timestamp('2015-12-27','YYYY-MM-DD');
  MIN_CREATION_DATE := to_timestamp('2015-12-01','YYYY-MM-DD');
  retention_period  := to_timestamp('2015-12-27','YYYY-MM-DD');
  batch_size        := 100000;
  
  if retention_period < max_creation_date then
    retention_period := max_creation_date;  
  end if;
  
  select count(table_name) into table_partitioned from user_tables where partitioned = 'YES' and table_name='SCA_FLOW_INSTANCE';
  
  if table_partitioned > 0 then
   DBMS_OUTPUT.PUT_LINE ('SCA_FLOW_INSTANCE is partitioned ');
  else
   DBMS_OUTPUT.PUT_LINE ('SCA_FLOW_INSTANCE is not partitioned ');
  end if;
  
  SELECT Count(s.flow_id) into purgeable_instance
  FROM sca_flow_instance s
  WHERE s.created_time            >= MIN_CREATION_DATE
  AND s.created_time              <= MAX_CREATION_DATE
  AND s.updated_time              <= retention_period
  AND s.active_component_instances = 0
  AND s.flow_id NOT IN  (SELECT r.flow_id FROM temp_prune_running_insts r)
  AND s.flow_id IN
    (SELECT c.flow_id FROM sca_flow_to_cpst c, sca_entity e, sca_partition p WHERE c.composite_sca_entity_id = e.id)
  AND rownum <= batch_size;
   DBMS_OUTPUT.PUT_LINE ('Total purgeable flow instance: ' ||  purgeable_instance);
END;
/
