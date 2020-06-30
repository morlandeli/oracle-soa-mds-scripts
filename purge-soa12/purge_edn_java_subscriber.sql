create or replace
PROCEDURE PURGE_EDN_JAVA_SUBSCRIBER (sd IN timestamp, ed IN timestamp)  AS

  dequeue_options    dbms_aq.dequeue_options_t;
  message_properties dbms_aq.message_properties_t;
  message_handle     raw(16);
  event              edn_business_event;
  event_data         edn_event_data;
  log_id             number;
BEGIN

  log_id := edn_next_log_event_id;
  dbms_output.put_line('Starting to purge events..');  
  for rec in
       ( SELECT MSGID 
       FROM EDN_EVENT_QUEUE_TABLE
       WHERE TRUNC(ENQ_TIME) BETWEEN TRUNC(sd) AND TRUNC(ed) -- AND  SUBSCRIBER# = '3'
       )

  loop
    begin
      dbms_output.put_line('Purging msg with id: ' || rawtohex(rec.msgid)) ;
      
      dequeue_options.msgid         := rec.msgid;
      dequeue_options.consumer_name := 'edn_java_subscriber';
      dequeue_options.wait          := DBMS_AQ.no_wait;

      DBMS_AQ.DEQUEUE(
        queue_name         => 'edn_event_queue',
        dequeue_options    => dequeue_options,
        message_properties => message_properties,
        payload            => event_data,
        msgid              => message_handle);

      event := event_data.event;

      dbms_output.put_line('Purged event: ' || event.namespace || '::' || event.local_name);
      edn_log_message (log_id, 'Purged event: ' || event.namespace || '::' || event.local_name);
      dbms_output.put_line('Subject name: ' || event_data.subject_info);
      edn_log_message (log_id, 'Subject name: ' || event_data.subject_info);

      if event.payload is not null then
        if edn_logging_enabled = 1 then 
          dbms_output.put_line('Body: ' || event.payload.getStringVal());
          edn_log_message (log_id, 'Body: ' || event.payload.getStringVal());
        end if;
      else
        dbms_output.put_line('Event is compressed');
        edn_log_message (log_id, 'Event is compressed');
      end if;

      dbms_output.put_line('Done purged/dequeued for event ID: ' || rawtohex(rec.msgid)) ;
      edn_log_message(log_id, 'Done purged/dequeued for event ID: ' || rawtohex(rec.msgid)) ;
      
    end;
  end loop;
  commit;
      dbms_output.put_line('done commit') ;

  EXCEPTION
     WHEN OTHERS THEN
      dbms_output.put_line('Error in purging: ' || sqlerrm) ;
      edn_log_message (log_id, 'Error in purging: ' || sqlerrm);

END;
