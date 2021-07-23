SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure [dbo].[usp_cust_GetLocOcSr]

@orgid int,
@begindt datetime,
@enddt datetime
as

select *
from Location l
join surveyResponse sr
on l.objectId=sr.locationObjectId
where l.organizationObjectId=@orgid
and sr.begindate between @begindt and @enddt

--exec usp_cust_GetLocOcSr 463,'1/1/2008','1/1/2009'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
