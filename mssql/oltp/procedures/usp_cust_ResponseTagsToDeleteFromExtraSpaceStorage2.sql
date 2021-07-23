SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--exec usp_cust_ResponseTagsToDeleteFromExtraSpaceStorage2

create procedure usp_cust_ResponseTagsToDeleteFromExtraSpaceStorage2
as
declare @count int,@rtid	int
set nocount on;
set @count=0

declare mycursor cursor for
select objectId from _ResponseTagsToDeleteFromExtraSpaceStorage

open mycursor
fetch next from mycursor into @rtid
while @@Fetch_Status=0
begin
SET IDENTITY_INSERT dbo.ResponseTag ON  
  BEGIN TRY
    BEGIN TRANSACTION;

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
COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;
 
    DECLARE @ErrorNumber INT = ERROR_NUMBER();
    DECLARE @ErrorLine INT = ERROR_LINE();
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
    DECLARE @ErrorState INT = ERROR_STATE();
 
    PRINT 'Actual error number: ' + CAST(@ErrorNumber AS VARCHAR(10));
    PRINT 'Actual line number: ' + CAST(@ErrorLine AS VARCHAR(10));
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH


SET IDENTITY_INSERT dbo.ResponseTag Off
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
