SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_admin_BlockedProcesses]
as
BEGIN
	DECLARE @count int
    DECLARE @alertMessage VARCHAR(2000)
	DECLARE @delim char(1)
	SET @delim = CHAR(9)

/****** Object:  Table [dbo].[_tmpsql]    Script Date: 08/23/2011 16:13:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_tmpsql]') AND type in (N'U'))
DROP TABLE [dbo].[_tmpsql]
;

--exec dbo.usp_admin_BlockedProcesses

select	
			spid
		,   blocked
		,   waittime
		,   waittype
		,   status
		,   db_name(y.dbid) dbname
		,   y.sqltext
		,   sql_handle
		,   hostname
		,   program_name
		,   login_time
		,   loginame
		,   last_batch
		,   kpid
		,   lastwaittype
		,   waitresource
		,   uid
		,   cpu
		,   physical_io
		,   memusage
		,   ecid
		,   open_tran
		,   sid
		,   hostprocess
		,   cmd
		,   nt_domain
		,   nt_username
		,   net_address
		,   net_library
		,   context_info
		,   stmt_start
		,   stmt_end
		,   request_id
		into _tmpsql
	from	(
		select	x.*, sql.text sqltext
		from	master.dbo.sysprocesses	x
		cross apply sys.dm_exec_sql_text(x.sql_handle) sql
		where	x.blocked>0
		  and   x.waittime>10000
		   or   x.spid in (select blocked from sys.sysprocesses where blocked>0 and waittime>10000)
	)	y
--	where y.dbid !=9--activemqdb
		where y.dbid =5--activemqdb
	order by blocked desc;
	
	--select * from _tmpsql;
	select @count=COUNT(*) from _tmpsql
		select @count
	
	if @count > 0
	begin
		SET @alertMessage =
		'There are blocked SQLServer processes!' + CHAR(13) +
        'Server: ' + @@SERVERNAME + CHAR(13) +
        'Count: ' + convert(varchar(100), @count) + CHAR(13) +
        'See status email for more info.'

		--EXEC msdb.dbo.sp_send_dbmail
		--@profile_name = 'Alert', 
		--@recipients = '8016786926@vtext.com',
		----@recipients = 'mshare@mailman.xmission.com;8016786926@vtext.com',
		--@subject = 'Blocked SQLServer Pocesses ',
		--@body = @alertMessage;		--@importance = 'High';
	
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
--		@recipients = 'alert@mshare.net;8016786926@vtext.com;bluther@mshare.net',
		@recipients = 'bluther@mshare.net;8016786926@vtext.com',--;Developers@mshare.net',--;bluther@mshare.net',
		@subject = 'Blocked SQLServer Processes Status',
		--@body = @alertMessage,
		@body = 'The attached file contains the results from usp_admin_CheckDeadlocks.',
		@query = 'select * from _tmpsql',
		@query_result_width = 32767,
		@exclude_query_output = 1,
		@execute_query_database = 'mindshare',
		@attach_query_result_as_file = 1,
		@query_result_separator = @delim,
		@query_attachment_filename = 'blocks.csv'
		----@importance = 'High'
	end

	
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_tmpsql]') AND type in (N'U'))
DROP TABLE [dbo].[_tmpsql];
end;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
