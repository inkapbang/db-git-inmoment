SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure usp_cust_ResponseTagsToDeleteFromExtraSpaceStorage
as
declare @count int,@rtid	int

set @count=0

declare mycursor cursor for
select objectId from _ResponseTagsToDeleteFromExtraSpaceStorage

open mycursor
fetch next from mycursor into @rtid
while @@Fetch_Status=0
begin
SET IDENTITY_INSERT dbo.ResponseTag ON;  
insert into responsetag (
objectId
,responseObjectId
,tagObjectId
,sourceType
,userAccountObjectId
,[timestamp]
,transcriptionConfidence
,transcriptionConfidenceLevel
,tagVersion
,pearSource
,pearModelObjectId
)
select 
objectId
,responseObjectId
,tagObjectId
,sourceType
,userAccountObjectId
,[timestamp]
,transcriptionConfidence
,transcriptionConfidenceLevel
,tagVersion
,pearSource
,pearModelObjectId
from 
_ResponseTagsToDeleteFromExtraSpaceStorage
where objectid =@rtid
SET IDENTITY_INSERT dbo.ResponseTag Off;
--print cast(@count as varchar)+', '+cast(@rtid as varchar)
--delete from ResponseTag with (rowlock) where ObjectId =@rtId 
set @count=@count+1
fetch next from mycursor into @rtid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
