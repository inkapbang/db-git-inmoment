SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure usp_cust_WGsrtIdsToDelete
as
set nocount on
set arithabort on
declare @count int,@srtid	bigint

set @count=0

declare mycursor cursor for
select objectid from _WGsrtIdsToDelete

open mycursor
fetch next from mycursor into @srtid
while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+cast(@srtid as varchar)
delete from ResponseTag with (rowlock) where objectid =@srtid 

set @count=@count+1
fetch next from mycursor into @srtid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' ResponseTags Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
