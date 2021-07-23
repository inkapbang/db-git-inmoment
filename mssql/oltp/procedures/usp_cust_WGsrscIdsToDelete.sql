SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure usp_cust_WGsrscIdsToDelete
as
set nocount on
set arithabort on
declare @count int,@srscid	bigint

set @count=0

declare mycursor cursor for
select objectid from _WGsrscIdsToDelete

open mycursor
fetch next from mycursor into @srscid
while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+cast(@srscid as varchar)
delete from SurveyresponseScore with (rowlock) where objectid =@srscid 

set @count=@count+1
fetch next from mycursor into @srscid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' scores Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
