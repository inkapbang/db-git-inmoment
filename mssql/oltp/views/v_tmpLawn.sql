SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view [dbo].[v_tmpLawn] as
	select 
		l.name,
		sr.offercode,
		sr.offerobjectid,
		sr.objectid srobjectid,
		ani,
		begintime,
		sr.complete,
		sr.loyaltynumber
	from location l 
	join surveyresponse sr
		on l.objectId = sr.locationObjectId
	where 
		l.organizationobjectid=594
		and sr.begindate between '4/14/2008' and '4/19/2008'
		and sr.complete=1
		and l.hidden=0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
