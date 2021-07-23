SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_Rolldataforward_Days]
@orgid int
, @daysForward int = 10
as

--exec dbo.usp_cust_Rolldataforward_Days 

-- TAR - 20150710 - DBA-574 - made changes to roll forward an arbitrary number of days rather than a single month.

declare @res table(srobjectid int)

insert into @res
select sr.objectid
from location l with (nolock)
join surveyresponse sr with (nolock)
on l.objectid=sr.locationobjectid
where l.organizationobjectid=@orgid

declare @count int,@srobjectid int
set @count=0

declare mycursor cursor for
select srobjectid from @res

open mycursor
fetch next from mycursor into @srobjectid
while @@Fetch_Status=0
begin

-- TAR - 20150710 - DBA-574 - changes here
update surveyresponse with (rowlock) set begindate = dateadd(d, @daysForward, begindate) where objectid=@srobjectid
update surveyresponse with (rowlock) set begindateUTC = dateadd(d, @daysForward, begindateUTC) where objectid=@srobjectid
update surveyresponse  with (rowlock)set dateofservice = dateadd(d, @daysForward, dateofservice) where objectid=@srobjectid
--update surveyresponse with (rowlock) set begindate = dateadd(m, 1, begindate) where objectid=@srobjectid
--update surveyresponse with (rowlock) set begindateUTC = dateadd(m, 1, begindateUTC) where objectid=@srobjectid
--update surveyresponse  with (rowlock)set dateofservice = dateadd(m, 1, dateofservice) where objectid=@srobjectid

set @count=@count+1
print cast(@count as varchar)+', '+cast(@srobjectId as varchar)
fetch next from mycursor into @srobjectid
end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'

--exec dbo.usp_cust_Rolldataforward_Days 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
