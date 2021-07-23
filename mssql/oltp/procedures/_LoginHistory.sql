SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[_LoginHistory]
(
	@organizationObjectId int
	, @frequency varchar(10) = 'all' -- 'month', 'week', 'all'
	, @fdt datetime = null
	, @tdt datetime = null
)

as
/*
Usage:
exec _loginHistory 2575 -- 1187  --2575
*/
	declare @roles varchar(300)

	if (@fdt is null or @tdt is null)
	begin
		if @frequency = 'month' 
		begin
			SELECT @fdt = DATEADD(day, 1, DATEADD(MONTH,-1+DATEDIFF(MONTH,0,GETDATE()),-1));
			SELECT @tdt = DATEADD(day, 1, DATEADD(MONTH,0+DATEDIFF(MONTH,0,GETDATE()),-1));
		end
		if @frequency = 'week'
		begin
			SELECT @fdt = DATEADD(day, 1, DATEADD(WEEK,-1+DATEDIFF(WEEK,0,GETDATE()),-1));
			SELECT @tdt = DATEADD(day, 1, DATEADD(WEEK, DATEDIFF(WEEK,0,GETDATE()),-1));
		end
	end
	
	select @fdt, @tdt
	
	create table #roles(role_name varchar (200), object_id int)
	insert into #roles values ('SYS_ADMIN', 1), 
	('ORG_SETUP', 2), 
	('ORG_MANAGER', 3), 
	('SSO_BYPASS', 4), 
	('SURVEY_EDITOR', 5), 
	('REPORT_EDITOR', 6), 
	('USER_MANAGER', 7), 
	('USER', 8), 
	('TRANSLATOR', 9), 
	('TRANSCRIBER', 10), 
	('EMPLOYEE_MANAGER', 11), 
	('CUSTOMER_SERVICE_REP', 12), 
	('REPORT_SUBSCRIBER', 13), 
	('PERSONAL_DATA_VIEWER', 14), 
	('PROGRAM_MAINTENANCE', 15), 
	('AUDIT_LOG', 16), 
	('LARGE_REPORT_ROWCOUNT', 17), 
	('TAGGER', 18), 
	('PILOT', 19), 
	('ERROR_LOG', 20), 
	('AUTO_PROVISIONING_BYPASS', 21), 
	('SHOW_AUTO_TRANSCRIPTIONS', 22), 
	('REVIEW_REPLY', 23), 
	('MINDSHARE_EMPLOYEE_ADMIN', 24), 
	('SYSTEM_DIAGNOSTICS', 25), 
	('REPORT_EDITOR_ADVANCED', 26), 
	('SCORE_RECALC_RUNNER', 27), 
	('HIERARCHY_EDITOR', 28), 
	('SSO_ADMIN', 29), 
	('TEXT_ANALYTICS_ADMIN', 30), 
	('WEB_SERVICES_ADMIN', 31), 
	('CLIENT_DIAGNOSTICS', 32), 
	('PLUM_SERVERS', 33), 
	('REPORT_RUN_ENQUEUEING', 34), 
	('SOCIAL_ADMIN', 35), 
	('SERVICE_ACCOUNT', 36), 
	('CASE_MANAGER', 38), 
	('FEATURE_TOGGLE_MANAGER', 40), 
	('WEB_SERVICES', 100), 
	('WEB_SERVICE_UNRESTRICTED_SURVEY_DATA', 111), 
	('ADVANCED_THEME_EDITOR', 114), 
	('HUB_REDIRECT', 39), 
	('CASE_VIEWER', 41), 
	('CASE_ADMIN', 42), 
	('DIY_DASHBOARD_CREATOR', 43), 
	('HUB_USER_MANAGER', 44), 
	('INTERCEPT_ADMIN', 45), 
	('IMAGE_MANAGER', 46), 
	('BATCH_ANALYZER_USER', 47), 
	('IMAGE_VIEWER', 48)

	select distinct useraccountobjectid
	into #users
	from UserAccountLocation ual
	join Location l on l.objectId = ual.locationObjectId and l.organizationObjectId = @organizationObjectId
	union
	select distinct useraccountobjectid
	from UserAccountLocationCategory ualc
	join LocationCategory lc on lc.objectId = ualc.locationCategoryObjectId and lc.organizationObjectId = @organizationObjectId
	

	select ua.objectId,
		ua.email, 
		ua.externalId 'sso',
		ua.firstName,
		ua.lastName,
		ael.timestamp,
		ael.eventType
	Into #UserAccount
	from UserAccount ua
	join #users u on ua.objectId = u.userAccountObjectId
	left join AccessEventLog ael on ael.userAccountObjectId = ua.objectId
	where 1=1
	and (case when @frequency = 'all' then 1 else (case when ael.timestamp >= @fdt and  ael.timestamp < @tdt then 1 else 0 end) end) = 1
	and ua.email not like '%inmoment.com%'
	and ua.email not like '%demo%'
	and ua.email not like '%test%'
	and ua.firstName not like '%test%'
	and ua.lastName not like '%test%'
	and ua.firstName not like '%demo%'
	and ua.lastName not like '%demo%'
	and ua.global = 0
	and ua.mindshareEmployee = 0
	
	select distinct a.objectId, a.[email], a.[sso], a.firstName, a.lastName, convert(varchar,max(timestamp),120) as LastLoginTimeUTC
	Into #LoginHistory
	from #UserAccount a
	group by a.objectid, a.[email], a.[sso], a.firstName, a.lastName
	
	select distinct	ua.objectId, r.role_name 
	into #userRoles	
	from #UserAccount ua
	left join UserAccountRole uar on uar.userAccountObjectId = ua.objectId
	left join #roles r on uar.role = r.object_id

	select distinct t.objectid,
	[email], [sso], firstName, lastName, LastLoginTimeUTC,	
	Roles = Stuff((Select ', '+role_name from #userRoles where objectId = t.objectId for xml path('')),1,2,'')
	, h.*
	from #userRoles t
	join #LoginHistory h on t.objectId=h.objectId
	order by h.email
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
