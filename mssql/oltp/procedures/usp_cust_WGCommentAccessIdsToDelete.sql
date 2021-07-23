SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure usp_cust_WGCommentAccessIdsToDelete
as
set nocount on
set arithabort on

declare @count int,@caid	bigint

set @count=0

declare mycursor cursor for
select objectid from _WgCommentAccessIdsToDelete

open mycursor
fetch next from mycursor into @caid
while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+cast(@caid as varchar)
delete from commentaccess with (rowlock) where objectid =@caid 

set @count=@count+1
fetch next from mycursor into @caid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' CommentAccess Records Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
