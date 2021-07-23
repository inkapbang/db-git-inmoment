SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure usp_cust_WGsrreqParamIdsToDelete
as
set nocount on 
set arithabort on
declare @count int,@srreqid	bigint

set @count=0

declare mycursor cursor for
select objectid from _WGsrreqIdsToDelete

open mycursor
fetch next from mycursor into @srreqid
while @@Fetch_Status=0
begin
--print cast(@count as varchar)+', '+cast(@srreqid as varchar)
delete from SurveyrequestParam with (rowlock) where Surveyrequestobjectid =@srreqid 

set @count=@count+1
fetch next from mycursor into @srreqid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' RequestParams Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
