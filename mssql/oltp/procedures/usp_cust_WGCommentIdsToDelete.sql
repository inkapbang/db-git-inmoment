SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure usp_cust_WGCommentIdsToDelete
as

set nocount on 
set arithabort on

declare @count int,@cid	bigint

set @count=0

declare mycursor cursor for
select objectid from _WGCommentIdsToDelete

open mycursor
fetch next from mycursor into @cid
while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+cast(@cid as varchar)
delete from comment with (rowlock) where objectid =@cid 

set @count=@count+1
fetch next from mycursor into @cid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Comment Records Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
