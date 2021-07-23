SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[DeleteEmailQueueEntries] (@beginDate DATETIME, @endDate DATETIME)
AS
BEGIN
	declare @queue TABLE (objectId INT, attachmentObjectId INT)
	-- TODO: Once the queue is caught up, remove the top 50000 limit from the below SQL
	INSERT INTO @queue (objectId, attachmentObjectId)
		SELECT top 50000 objectId, attachmentObjectId FROM EmailQueue WHERE creationDateTime BETWEEN @beginDate AND @endDate
	DECLARE @queueSize INT, @attachmentSize INT
	SELECT @queueSize = COUNT(*), @attachmentSize = SUM(CASE WHEN attachmentObjectId IS NOT NULL THEN 1 ELSE 0 END) FROM @queue
	PRINT 'Deleting ' + CAST(@queueSize AS VARCHAR(15)) + ' emails, ' + CAST(@attachmentSize AS VARCHAR(15)) + ' attachments'
	BEGIN TRAN
	BEGIN TRY
		delete from emailqueue where objectid in (select objectId from @queue)
		delete from binarycontent with (rowlock) where objectid in (select attachmentObjectId from @queue)
--		delete from emailqueue with (rowlock) where objectid in (select objectId from @queue)
		commit
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION
		EXEC RethrowError
	END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
