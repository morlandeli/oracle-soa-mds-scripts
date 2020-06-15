SELECT * FROM user_scheduler_jobs

SELECT * FROM user_jobs

select session_id, running_instance, elapsed_time, cpu_used
from user_scheduler_running_jobs
where job_name = 'DELETE_INSTANCES_AUTO_JOB1'; 


select SCHEDULE_TYPE,START_DATE,REPEAT_INTERVAL
from user_scheduler_schedules
where schedule_name = 'DELETE_INSTANCES_AUTO_SCH1'; 

select log_date, status from user_scheduler_job_log where job_name = 'DELETE_INSTANCES_AUTO_JOB1' order
by log_date;


select log_date, status, req_start_date, actual_start_date, run_duration
from user_scheduler_job_run_details
where job_name = 'DELETE_INSTANCES_AUTO_JOB1'
order by log_date; 



SELECT * FROM user_scheduler_jobs w WHERE w.job_name = 'DELETE_INSTANCES_AUTO_JOB1'

SELECT * FROM user_scheduler_programs pg
WHERE pg.PROGRAM_NAME='DELETE_INSTANCES_AUTO_PRG'

SELECT * FROM user_scheduler_program_args pa
 WHERE pa.PROGRAM_NAME = 'DELETE_INSTANCES_AUTO_PRG'



BEGIN
 DBMS_SCHEDULER.DEFINE_PROGRAM_ARGUMENT (
   program_name            => 'DELETE_INSTANCES_AUTO_PRG',
   argument_position       => 7,
   argument_name           => 'PURGE_PARTITIONED_COMPONENT',
   argument_type           => 'VARCHAR2',
   default_value           => 'FALSE');
END;
/
