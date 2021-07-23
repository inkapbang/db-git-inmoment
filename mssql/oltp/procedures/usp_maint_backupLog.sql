SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure dbo.usp_maint_backupLog
as
--exec usp_maint_backupLog

if  exists (
	select * from sys.tables
	where object_id = OBJECT_ID(N'[dbo].[_log]'))
begin
	drop table _log
	create table _log(LogDate datetime,ProcessInfo varchar(25), [Text] varchar(500))
end

insert into _log
EXEC [sp_readerrorlog] 0;



--drop table backuplog
--create table backuplog(LogDate datetime,ProcessInfo varchar(25), [Text] varchar(500))

declare @newerthandate datetime--,@lastdate datetime
set @newerthandate=(select max(LogDate) from _log)
--set @lastdate = (select max(LogDate) from _log)
--select @newerthandate--,@lastdate

insert into backuplog
select * 
from _log 
where [text] like '%backup%'
and logdate > @newerthandate 
order by logdate desc;

--select * from backuplog
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
