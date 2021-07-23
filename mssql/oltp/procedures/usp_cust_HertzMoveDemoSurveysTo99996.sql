SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure [dbo].[usp_cust_HertzMoveDemoSurveysTo99996]
as
update surveyresponse with (rowlock) set offerobjectid=600,locationObjectId=66158
where objectid in 
(
select sr.objectid 
from surveyresponse sr with (nolock)
join location l with (nolock)
on l.objectid=sr.locationobjectid
where sr.locationObjectId=27044 and sr.offerobjectId in (2920, 600)
and sr.begindate >='12/1/2008'
and sr.begindate <'12/18/2008'
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
