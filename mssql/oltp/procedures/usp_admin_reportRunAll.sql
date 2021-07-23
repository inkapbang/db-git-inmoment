SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_admin_reportRunAll]asselect org, max(acctMngr) as acctMngr, report, sched, count(report) as numReports, sum(error) as numErrors,  count(rows) as numWithRowCount, avg(rows) as avgRows, max(rows) as maxRows, cast(avg(elapsedTime) as float(10))/1000 as AvgSeconds,cast(Max(elapsedTime) as float(10))/1000 as MaxgSeconds,cast(Sum(elapsedTime) as float(10))/1000 as TotalSecondsinto #tmp1 from (select O.name as org, UA.firstName + ' ' + UA.lastName as acctMngr, R.name as report, RS.name as sched, (case when RLE.exception is not null then 1 else 0 end) as error, (case RLE.elapsedTime when -1 then null else RLE.elapsedTime end) as elapsedTime, RLE.rows as rows from ReportLogEntry RLE with (nolock) left outer join ReportSchedule RS with (nolock)on RLE.reportScheduleObjectId = RS.objectId inner join Report R on RLE.reportObjectId = R.objectId inner join Organization O on R.organizationObjectId = O.objectId left outer join UserAccount UA on O.accountManagerObjectId = UA.objectId where RLE.creationDateTime between dateadd(dd,datediff(dd,0,getdate()),0)and getdate()and RLE.reportScheduleObjectId is not null) as dtgroup by org, report, sched --with rollup order by org, report, sched--select * from #tmp1delete from #tmp1 where maxrows=0select * from #tmp1drop table #tmp1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
