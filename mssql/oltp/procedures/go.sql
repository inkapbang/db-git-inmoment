SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[go]
as
--exec dbo.go

IF  Not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_who2]') AND type in (N'U'))
begin
--drop table _who2
CREATE TABLE [dbo].[_who2](
	[SPID] [int] NOT NULL,
	[Status] [varchar](250) NULL,
	[login] [varchar](250) NULL,
	[HostName] [varchar](250) NULL,
	[BlkBy] [varchar](250) NULL,
	[DBName] [varchar](250) NULL,
	[Command] [varchar](250) NULL,
	[CPUTime] [varchar](250) NULL,
	[DiskIO] [varchar](250) NULL,
	[LastBatch] [varchar](250) NULL,
	[ProgramName] [varchar](250) NULL,
	[SPID2] [varchar](250) NULL,
	[REQUESTID] [varchar](250) NULL,
	[sqltext] [varchar](max) NULL
) ON [PRIMARY]


end;

truncate table _who2;

insert into _who2(
SPID,
Status,
login,
HostName,
BlkBy,
DBName,
Command,
CPUTime,
DiskIO,
LastBatch,
ProgramName,
SPID2,
REQUESTID
)

exec sp_who2
--chk
--select * from _who2 order by BlkBy desc,SPID
--

IF  Not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_runningqueries]') AND type in (N'U'))
begin
--drop table _runningqueries
create table _runningqueries(
text varchar(max),session_id int,status varchar(250),command varchar(250),cpu_time varchar(250),total_elapsed_time varchar(250))
end;

truncate table _runningqueries
insert into _runningqueries
SELECT   cast(st.text as varchar(max)), r.session_id, r.status, r.command, r.cpu_time, r.total_elapsed_time  
FROM sys.dm_exec_requests r  CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS st

select * from _runningqueries;

select * 
from _who2 w
left join _runningqueries r
on w.SPID=r.session_id
order by BlkBy desc,SPID;

exec usp_admin_CheckDeadlocks;

--exec dbo.go
--dbcc inputbuffer(263)
Return
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
