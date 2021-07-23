SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[usp_admin_Reportrunauto]
	@user varchar (25),
	@email varchar(50)
as 
--select 'Hello World','User ',@user,'E-mail',@email

with mycte as (
            select 
				O.name as org, 
				UA.firstName + ' ' + UA.lastName as acctMngr, 
				lsv.value as report,
				RS.name as sched, 
				(case when RLE.exception is not null then 1 else 0 end) as error,
				(case RLE.elapsedTime when -1 then null else RLE.elapsedTime end) as elapsedTime,
				RLE.rows as rows 
			from ReportLogEntry RLE with(nolock)left outer join ReportSchedule RS with(nolock)
			on RLE.reportScheduleObjectId = RS.objectId inner join Report R with(nolock)
			on RLE.reportObjectId = R.objectId inner join Organization O with(nolock)
			on R.organizationObjectId = O.objectId left outer join UserAccount UA with(nolock)
			on O.accountManagerObjectId = UA.objectId 
			join localizedstringvalue lsv
			on r.nameobjectid=lsv.localizedstringobjectid
            where RLE.creationDateTime between dateadd(dd,datediff(dd,0,getdate()),0)and getdate()
			and o.enabled=1
			and lsv.localekey='en_us'
            
            -- use this to toggle whether or not manual reports are included (?)
             and RLE.reportScheduleObjectId is not null
)

select org, max(acctMngr) as acctMngr, report, sched,
                 count(report) as numReports, sum(error) as numErrors, 
                 count(rows) as numWithRowCount,-- avg(rows) as avgRows, max(rows) as maxRows, 
                 cast(avg(elapsedTime)as decimal(10,2))/1000 as avgTime, 
				 cast(max(elapsedTime) as decimal(10,2))/1000 as maxTime, 
                 cast(sum(elapsedTime)as decimal(10,2))/1000 as totalTime--, --grouping(org) as totalRow, 
                 --grouping(report) as orgRow, grouping(sched) as reportRow

from mycte where acctMngr=@user

--where org is not null
             group by org, report, sched --with rollup
             order by org, report, sched
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
