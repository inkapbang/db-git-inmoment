SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure dbo.usp_cust_SprintCompletesNincompletes
@dt datetime
as

select '688	Sprint/Nextel - Public Safety compete',begindate,textvalue  
from survey s 
join surveyresponse sr
on s.objectid=sr.surveyobjectid
join surveyresponseanswer sra
on sr.objectid=sra.surveyresponseobjectid
where s.organizationobjectid =688
and sr.complete=1
and sr.begindate>@dt
and sra.datafieldobjectid=18109

--688	Sprint/Nextel - Public Safety
--select *
select '688	Sprint/Nextel - Public Safety incompete',begindate,textvalue   
from survey s 
join surveyresponse sr
on s.objectid=sr.surveyobjectid
join surveyresponseanswer sra
on sr.objectid=sra.surveyresponseobjectid
where s.organizationobjectid =688
and sr.complete=0
and sr.begindate>@dt
and sra.datafieldobjectid=18109


--696	Sprint - Assigned Care completes
select '696	Sprint - Assigned Care completes',begindate,textvalue 

from survey s 
join surveyresponse sr
on s.objectid=sr.surveyobjectid
join surveyresponseanswer sra
on sr.objectid=sra.surveyresponseobjectid
where s.organizationobjectid =696
and sr.complete=1
and sr.begindate>@dt
and sra.datafieldobjectid=18913


--696	Sprint - Assigned Care incompletes
--select * 
select '696	Sprint - Assigned Care incompletes',begindate,textvalue 
from survey s 
join surveyresponse sr
on s.objectid=sr.surveyobjectid
join surveyresponseanswer sra
on sr.objectid=sra.surveyresponseobjectid
where s.organizationobjectid =696
and sr.complete=0
and sr.begindate>@dt
and sra.datafieldobjectid=18913

--exec dbo.usp_cust_SprintCompletesNincompletes '1/1/2008'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
