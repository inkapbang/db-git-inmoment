SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure usp_cust_WGsralIdsToDelete
as
set nocount on
set arithabort on 
declare @count int,@sralid	bigint

set @count=0

declare mycursor cursor for
select objectid from _WGsralIdsToDelete

open mycursor
fetch next from mycursor into @sralid
while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+cast(@sralid as varchar)
delete from SurveyResponseALert with (rowlock) where objectid =@sralid 

set @count=@count+1
fetch next from mycursor into @sralid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Alerts Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
