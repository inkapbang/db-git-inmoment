SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_admin_rollABCdemoDataOnemonth] 
as
declare @count int,@srobjectid bigint--,@OCID int,@gatewayid int
set @count=0

declare mycursor cursor for
select sr.objectid
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid=sr.locationobjectid
where l.organizationobjectid=500

open mycursor
fetch next from mycursor into @srobjectid--,@OCID,@gatewayID
while @@Fetch_Status=0
begin

print cast(@srobjectid as varchar)--+', '+cast(@OCID as varchar)+', '+cast(@gatewayID as varchar)
update surveyresponse with (rowlock)
set begindate= dateadd(mm,1,begindate),
begindateUTC= dateadd(mm,1,begindateUTC)
where objectid=@srobjectid

--update surveyresponse with (rowlock)
--set begindateUTC= dateadd(mm,1,begindateUTC) 
--where objectid=@srobjectid

set @count=@count+1
fetch next from mycursor into @srobjectid--,@OCID,@gatewayID
end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'
--EXEC DBO.usp_admin_rollABCdemoDataOnemonth 
---------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
