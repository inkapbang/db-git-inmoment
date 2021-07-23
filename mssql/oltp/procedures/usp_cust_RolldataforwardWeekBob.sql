SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_RolldataforwardWeekBob]
@orgid int
as

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

update surveyresponse with (rowlock) set begindate = dateadd(wk, -3, begindate) where objectid=@srobjectid
update surveyresponse with (rowlock) set begindateUTC = dateadd(wk, -3, begindateUTC) where objectid=@srobjectid
--update surveyresponse  with (rowlock)set dateofservice = dateadd(m, 1, dateofservice) where objectid=@srobjectid
set @count=@count+1
print cast(@count as varchar)+', '+cast(@srobjectId as varchar)
fetch next from mycursor into @srobjectid
end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'

--exec dbo.usp_cust_RolldataforwardWeekBob1864
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
