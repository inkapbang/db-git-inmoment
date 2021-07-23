SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure usp_cust_WGsraIdsToDelete
as
set nocount on
set arithabort on

declare @count int,@sraid	bigint

set @count=0

declare mycursor cursor for
select objectid from _WGsraIdsToDelete

open mycursor
fetch next from mycursor into @sraid
while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+cast(@sraid as varchar)
delete from surveyresponseanswer with (rowlock) where objectid =@sraid 

set @count=@count+1
fetch next from mycursor into @sraid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' SurveyResponseAnswer Records Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
