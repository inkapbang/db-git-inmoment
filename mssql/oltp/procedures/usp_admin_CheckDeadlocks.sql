SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_admin_CheckDeadlocks]
AS
BEGIN
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
	from	(
		select	x.*, sql.text sqltext
		from	master.dbo.sysprocesses	x
		cross apply sys.dm_exec_sql_text(x.sql_handle) sql
		where	x.blocked>0
		  and   x.waittime>10000
		   or   x.spid in (select blocked from sys.sysprocesses where blocked>0 and waittime>10000)
	)	y
	--where y.dbid !=12--activemqdb
	where y.dbid =5	
	order by blocked desc
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
