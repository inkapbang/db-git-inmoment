SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--select datepart(weekday,getdate())
--
--select datename(dw,getdate())
--
--use warehousei
--go
--
--select * from location l
--join offercode oc
--on l.objectid=oc.locationobjectid
--join surveyresponse sr
--on oc.objectid=sr.offercodeobjectid
--where l.organizationobjectid in (
--select objectid from organization where name like 'express%'
--)
--
----select * from datafield where organizationobjectid =734 order by objectid 
------------
CREATE procedure [dbo].[usp_cust_expressFittingRoom]
as
declare @dt datetime
set @dt = dateadd(dd,-3,getdate())

declare @res table(srobjectid int)

insert into @res
select distinct sr.objectid 
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid=sr.locationobjectid
join surveyresponseanswer sra with (nolock)
on sr.objectid=sra.surveyresponseobjectid
where l.organizationobjectid = 734
and sr.complete=1
and sr.begindate >=@dt
and sra.datafieldobjectid=21020

except

select distinct sr.objectid  
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid=sr.locationobjectid
join surveyresponseanswer sra with (nolock)
on sr.objectid=sra.surveyresponseobjectid
where l.organizationobjectid = 734
and sra.datafieldobjectid=22201
and sr.complete=1
and sr.begindate >=@dt

--select * from @res
---
--add FittingRoomVIsit to sra 
declare @count int,@srobjectId	int,@newsequence int,@fittingroomvisit int

set @count=0

declare mycursor cursor for
select srobjectid from @res

open mycursor
fetch next from mycursor into
@srobjectId

while @@Fetch_Status=0
begin
set @newsequence=(select max(sequence)+1 from surveyresponseanswer with (nolock) where surveyresponseobjectid=@srobjectid)
set @fittingroomvisit=(select datafieldoptionobjectid from surveyresponseanswer where surveyresponseobjectid=@srobjectid and datafieldobjectid=21020)

print cast(@count as varchar)+', '+cast(@srobjectId as varchar)+', '+cast(@newsequence as varchar)+', '+cast(@fittingroomvisit as varchar)
--

--insert into surveyresponseanswer(
--surveyResponseObjectId,
--msrepl_tran_version,
--sequence,
--dataFieldObjectId,
--dataFieldOptionObjectId
--)
--select @srobjectid,newid(),@newsequence,22201,
--		case 
--			when @fittingroomvisit=57125 then 60657
--		else 60656
--		end


insert into surveyresponseanswer(
surveyResponseObjectId,
sequence,
dataFieldObjectId,
dataFieldOptionObjectId
)
select @srobjectid,@newsequence,22201,
		case 
			when @fittingroomvisit=57125 then 60657
		else 60656
		end

set @count=@count+1
fetch next from mycursor into 
@srobjectId

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'

--dbo.usp_cust_expressFittingRoom
--------------------------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
