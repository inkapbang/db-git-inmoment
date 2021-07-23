SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--------------
CREATE proc dbo.usp_admin_donutclubalert
as
declare @dt table (dt datetime)
declare @today datetime
set @today =(select cast(floor(cast(getdate() as int))as datetime))

insert into @dt select '8/8/2008'
insert into @dt select '10/3/2008'
insert into @dt select '11/28/2008'
insert into @dt select '6/30/2008'

--select * from @dt
--select @today

if @today in (select * from @dt)
begin 
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = '8016786926@vtext.com',
		@subject = 'Donut club today',
		@body = 'Your day for Donut to bring donuts',
		--@query = 'exec usp_admin_Check_SurveyStepWithoutPrompt',
		@query_result_width = 32767,
		@exclude_query_output = 0,
		@execute_query_database = 'master',
		--@attach_query_result_as_file = 1,
		--@query_result_separator = @delim,
		--@query_attachment_filename = 'SurveyStepWithoutPrompt.csv',
		@importance = 'High'
end --if


--exec dbo.usp_admin_donutclubalert
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
