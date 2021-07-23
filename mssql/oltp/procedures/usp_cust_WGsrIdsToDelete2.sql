SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure usp_cust_WGsrIdsToDelete2
as
set nocount on 
set arithabort on

declare @count int,@srid	bigint

set @count=0

declare mycursor cursor for
select objectid from _WGsrIdsToDelete2

open mycursor
fetch next from mycursor into @srid
while @@Fetch_Status=0
begin
print cast(@count as varchar)+', '+cast(@srid as varchar)
delete from surveyresponse with (rowlock) where objectid =@srid 

set @count=@count+1
fetch next from mycursor into @srid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' srids Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
