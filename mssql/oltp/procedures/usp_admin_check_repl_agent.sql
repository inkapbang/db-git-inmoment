SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
---log reader agent
CREATE procedure [dbo].[usp_admin_check_repl_agent] 
as
declare @agents table(
jobname varchar(50), descript varchar(50)
)
insert into @agents values('BORIS-mindshare-2','logReader agent')
insert into @agents values('BORIS-mindshare-Mindshare-TREASURE-62','distribution agent')
--insert into @agents values('BORIS-mindshare-mindshare-JONAS-67','distribution agent')
insert into @agents values('BORIS-mindshare-Mindshare-APE-63','distribution agent')

declare @status int
declare @jobname varchar(50)
declare @descript varchar(50)
DECLARE @alertMessage VARCHAR(2000)
--set @status =0

declare mycursor cursor for 
select jobname,descript from @agents

open mycursor
fetch next from mycursor into @jobname,@descript

while @@fetch_status =0
begin
 
select @status=
(
select run_status from msdb..sysjobhistory where instance_id=(
	select max(instance_id) from msdb..sysjobhistory where job_id=(
		select job_id from msdb..sysjobs where name = @jobname
)))
--select @jobname,@descript,isnull(@status,0)
--set @status =3
if isnull(@status,0) =3 --send alert
begin

SET @alertMessage =
		'Boris, '+ @descript + ' job '+@jobname + ' Not Running. '
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = '8016786926@vtext.com;alert@yahoogroups.com',
		@subject = 'Replication Jobs on Boris have failed',
		@body = @alertMessage,
		@importance = 'High'
		
end --if
  
fetch next from mycursor into @jobname,@descript

End
close mycursor
deallocate mycursor
--exec usp_admin_check_repl_agent
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
