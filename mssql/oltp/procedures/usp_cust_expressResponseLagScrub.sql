SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_expressResponseLagScrub]
as

--exec dbo.usp_cust_expressResponseLagScrub

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_res23]') AND type in (N'U'))
DROP TABLE [dbo].[_res23]
;
with mycte as(
select sr.*
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid =sr.locationobjectid 
where l.organizationobjectid =734
--and sr.begindate >='1/14/2011'
and sr.begindate >=dateadd(dd,-3,getdate())
--and sr.offercodeobjectid!=1424676
)
select * 
into _res23
from mycte 
where datediff(dd,dateofservice,begindate)>14
and not(offerObjectId=1652 and locationObjectId=492188)--offercodeobjectid!=1424676
--select * from _res23
--select * from surveyresponse where objectid in (select objectid from _res23)
--modify
------------------
declare @count int,@srid INT,@val	int,@newsequence int

set @count=0

declare mycursor cursor for
select objectid from _res23

open mycursor
fetch next from mycursor into @srid

while @@Fetch_Status=0
BEGIN

print cast(@count as varchar)+', '+cast(@srid as varchar)

--preserve offercode in externalid
update surveyresponse with (rowlock) 
set externalid=cast(offerobjectid as varchar(30))
where objectid=@srid

--change offercodeobjectid
update surveyresponse with (rowlock) 
set offerObjectId=1652,locationObjectId=492188
where objectid =@srid

set @count=@count+1
fetch next from mycursor into @srid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'

Return
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
