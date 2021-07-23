SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE _GetUsersAndReportsByOrg
	-- Add the parameters for the stored procedure here
	@organizationId int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- get list of users
	select ua.objectId, ua.email, ua.lastname, ua.firstname
	, case when ua.enabled = 1 then 'Yes' else 'No' end as [Enabled]
	, case when ua.mindshareemployee = 1 then 'Yes' else 'No' end as [InMoment Employee]
	into #users
	from useraccount (nolock) ua
	inner join organizationuseraccount (nolock) oua on oua.useraccountobjectid = ua.objectid
	where oua.organizationobjectid = @organizationId

	union

	select ua.objectId, ua.email, ua.lastname, ua.firstname
	, case when ua.enabled = 1 then 'Yes' else 'No' end as [Enabled]
	, case when ua.mindshareemployee = 1 then 'Yes' else 'No' end as [InMoment Employee]
	from useraccount (nolock) ua
	inner join useraccountlocationcategory (nolock) ualc on ualc.useraccountobjectid = ua.objectid
	inner join locationcategory (nolock) lc on lc.objectid = ualc.locationcategoryobjectid
	where lc.organizationobjectid = @organizationId

	union

	select ua.objectId, ua.email, ua.lastname, ua.firstname
	, case when ua.enabled = 1 then 'Yes' else 'No' end as [Enabled]
	, case when ua.mindshareemployee = 1 then 'Yes' else 'No' end as [InMoment Employee]
	from useraccount (nolock) ua
	inner join useraccountlocation (nolock) ual on ual.useraccountobjectid = ua.objectid
	inner join location (nolock) l on l.objectid = ual.locationobjectid
	where l.organizationobjectid = @organizationId

	-- testing
	--select * from #users 

	-- get last login by user
	select u.objectid as UserId
	, max(ael.timestamp) as MostRecentLogin
	into #userLogins
	from #users u
	inner join AccessEventLog (nolock) ael on ael.userAccountObjectId = u.objectId
	where ael.eventType = 0 -- success
	group by u.objectid

	--/*
	select u.*, ul.MostRecentLogin
	from #users u
	left outer join #userLogins ul on ul.UserId = u.objectId
	order by u.email
	--*/

	-- get reports for org
	select p.objectid, fn.value as FolderName, lsv.value as ReportName
	into #reports
	from Page (nolock) p
	inner join localizedStringValue (nolock) lsv on lsv.localizedstringobjectid = p.nameobjectid and lsv.localekey = 'en_us'
	left outer join folder (nolock) f on f.objectid = p.folderobjectid
	left outer join localizedstringvalue (nolock) fn on fn.localizedstringobjectid = f.nameobjectid and fn.localekey = 'en_us'
	where p.organizationobjectid = @organizationId

	-- get report executions
	select p.*
	, ple.objectid as pagelogobjectid, ple.creationDateTime, ua.objectId as userId,ua.email
	, row_number() over (partition by p.objectid order by ple.creationDateTime desc) as rownum
	into #reportExecutions
	from #reports p
	inner join pagelogentry (nolock) ple on p.objectid = ple.pageobjectid and ple.creationdatetime >= '20200101' 
	left outer join PageLogEntryUserAccount (nolock) pleua on pleua.pageLogEntryObjectId  = ple.objectId
	left outer join UserAccount (nolock) ua on ua.objectId = pleua.userAccountObjectId

	-- get report counts
	select re.objectid, COUNT(re.objectid) as ReportCount
	into #reportCounts
	from #reportexecutions re
	group by re.objectId

	-- get most recent execution
	select re.objectId, re.creationDateTime, re.userId, re.email
	into #mostRecentReports
	from #reportExecutions re
	where re.rownum = 1

	-- reports output
	select r.*, rc.ReportCount, mrr.creationDateTime as MostRecentRun, mrr.userId, mrr.email
	from #reports r 
	inner join #reportCounts rc on rc.objectId = r.objectId
	inner join #mostRecentReports mrr on mrr.objectId = r.objectId
	order by r.foldername, r.reportname

	-- cleanup
	drop table #users
	drop table #userLogins
	drop table #reports
	drop table #reportExecutions
	drop table #reportCounts
	drop table #mostRecentReports
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
