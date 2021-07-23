SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_admin_PageLog]
@orgId int,@begindt datetime,@enddt datetime
AS
BEGIN
	select 
		status, creationDateTime, orgName, folderObjectId, folderName, pageObjectId, pageName, schedule, usr, elapsedTime, rows, host
	from(
		select 
			'status'=case  
				when ple.exception is null 
					then 'Success'
					else 'failed' 
					end,
				ple.creationDateTime,
				o.name orgName,
				p.objectId pageObjectId,
				lsv.value pageName,
			'schedule'=case  
				when ps.objectId is null 
					then 'manual'
					else 'scheduled'
					end,
				ua.firstName+' '+ua.lastName as 'usr',
				elapsedTime,
				rows,
				host,
				f.objectid folderObjectId
		from Page p
			join PageLogEntry ple
				on p.objectId = ple.pageObjectId
			join Organization o
				on p.organizationObjectId = o.objectId
			join PageLogentryUserAccount pleua
				on ple.objectid = pleua.pageLogEntryObjectId
			join Folder f
				on f.objectId = p.folderObjectId
			join LocalizedStringValue lsv
				on p.nameObjectId = lsv.localizedStringObjectId
			join UserAccount ua
				on ua.objectId = pleua.userAccountObjectId
			left outer join PageSchedule ps
				on ps.objectId = ple.pageScheduleObjectId
		where o.objectId = @orgId
			and ple.creationDateTime between @begindt and @enddt
			and lsv.localeKey = 'en_us'
	)as a

	join
	(
		select f.objectId 'folObjectId', lsv.value 'folderName'
		from Folder f
			join LocalizedStringValue lsv
				on f.nameObjectId = lsv.localizedStringObjectId
		where f.organizationObjectId = @orgId
			and localeKey = 'en_us'
	)as b

	on a.folderObjectId = b.folObjectId
	order by creationDateTime desc

	--exec dbo.usp_admin_PageLog 444,'1/28/2009','2/04/2009'
END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
