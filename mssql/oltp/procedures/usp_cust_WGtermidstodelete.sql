SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure usp_cust_WGtermidstodelete
as
set nocount on 
set arithabort on

declare @count int,@tid	bigint

set @count=0

declare mycursor cursor for
select objectid from _WGtermidstodelete

open mycursor
fetch next from mycursor into @tid
while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+cast(@tid as varchar)
delete from termannotation with (rowlock) where objectid =@tid 

set @count=@count+1
fetch next from mycursor into @tid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +'termannotattion Records Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
