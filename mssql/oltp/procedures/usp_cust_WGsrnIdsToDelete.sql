SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
Create procedure usp_cust_WGsrnIdsToDelete
as
set nocount on
set arithabort on
declare @count int,@srnid	bigint

set @count=0

declare mycursor cursor for
select objectid from _WGsrnIdsToDelete

open mycursor
fetch next from mycursor into @srnid
while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+cast(@srnid as varchar)
delete from SurveyResponseNOte with (rowlock) where objectid =@srnid 

set @count=@count+1
fetch next from mycursor into @srnid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Notes Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
