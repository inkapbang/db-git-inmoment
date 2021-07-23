SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
Create procedure usp_cust_tagaidstodelete
as 
set nocount on
set arithabort on
declare @count int,@tagaid	bigint

set @count=0

declare mycursor cursor for
select objectid from _tagaIdsToDelete

open mycursor
fetch next from mycursor into @tagaid
while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+cast(@cid as varchar)
delete from tagannotation with (rowlock) where objectid =@tagaid 

set @count=@count+1
fetch next from mycursor into @tagaid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +'Tagannotation Records Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
