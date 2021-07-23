SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create PROCEDURE [dbo].[usp_admin_DeleteEmailQueueEntries_master] (@beginDate DATETIME, @endDate DATETIME, @batchsize int)--numberofEmailsToDelete)
AS
set nocount on;
/* modified by Bob Luther Jan 28,2008*/

BEGIN
	DECLARE @queue TABLE (objectId INT, attachmentObjectId INT)
	-- TODO: Once the queue is caught up, remove the top 50000 limit from the below SQL
	INSERT INTO @queue (objectId, attachmentObjectId)
		SELECT top 50000 objectId, attachmentObjectId FROM EmailQueue with (nolock) WHERE creationDateTime BETWEEN @beginDate AND @endDate

	DECLARE @queueSize INT, @attachmentSize INT
	SELECT @queueSize = COUNT(*), @attachmentSize = SUM(CASE WHEN attachmentObjectId IS NOT NULL THEN 1 ELSE 0 END) FROM @queue
	PRINT 'Deleting ' + CAST(@queueSize AS VARCHAR(15)) + ' emails, ' + CAST(@attachmentSize AS VARCHAR(15)) + ' attachments'

	declare @cr int
	Set @cr=@queuesize
	---Delete emailqueue and binarycontent objects associated.
	while @cr > 0
		Begin
			BEGIN TRAN
			BEGIN TRY
				--select @cr
				exec usp_admin_deleteEmailQueueEntries @begindate,@enddate,@batchsize
				commit
				set @cr =@cr - @batchsize
			END TRY
			BEGIN CATCH
				IF XACT_STATE() <> 0
					ROLLBACK TRANSACTION
				EXEC RethrowError
			END CATCH
			waitfor delay '00:00:01' --delay between iterations so tables don't lock
		end--while
END
------------------------
----test
--DECLARE @DaysToKeep DATETIME
--SET @DaysToKeep = DATEADD(day, -68, CONVERT(VARCHAR(10), GETDATE(), 101))--days to keep in email queue
--EXEC [dbo].[usp_admin_DeleteEmailQueueEntries_master] '1/1/2000',  @DaysToKeep, 200 --batch size to delete
------
------select DATEADD(day, -72, CONVERT(VARCHAR(10), GETDATE(), 101))
--declare @enddate datetime
--set @ENDDATE= DATEADD(day, -68, CONVERT(VARCHAR(10), GETDATE(), 101))
--
--	DECLARE @queue TABLE (objectId INT, attachmentObjectId INT)
--	-- TODO: Once the queue is caught up, remove the top 50000 limit from the below SQL
--	INSERT INTO @queue (objectId, attachmentObjectId)
--		SELECT top 50000 objectId, attachmentObjectId FROM EmailQueue with (nolock) WHERE creationDateTime BETWEEN '1/1/2000' AND @enddate
--	select * from @queue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
