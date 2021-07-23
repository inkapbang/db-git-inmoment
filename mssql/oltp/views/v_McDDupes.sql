SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view [dbo].[v_McDDupes]
as

select 
	* 
from 
	(
		select 
			sr.objectid srobjectid,
			sr.begindate,
			sr.dateofservice,
			sr.begintime,
			l.objectid lobjectid,
			sra.numericvalue
			--,replace(replace(replace(replace(sra.textvalue,'(',''),')',''),'-',''),' ','')
		from location l with (nolock)
		join surveyresponse sr with (nolock)
			on l.objectId = sr.locationObjectId
		left outer join surveyresponseanswer sra with (nolock)
			on sr.objectid = sra.surveyresponseobjectid
		where 
			l.organizationobjectid=569
			and l.objectid in 
				(
					select 
						locationObjectId 
					from dbo.ufn_app_LocationsInCategoryOfType(1003)
					where locationcategoryobjectid=14999--Canada
				)
			and l.enabled = 1
			and l.hidden = 0
			and sr.complete = 1
			and sra.datafieldobjectid = 25757
	)as a
left outer join 
	(
		select  
			sra.surveyresponseobjectid ,
			replace(replace(replace(replace(sra.textvalue,'(',''),')',''),'-',''),' ','') as contactnumber
		from surveyresponseanswer sra with (nolock)
		where datafieldobjectid = 25846
	) as b
	on a.srobjectid=b.surveyresponseobjectid

--select * from v_McDDupes
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
