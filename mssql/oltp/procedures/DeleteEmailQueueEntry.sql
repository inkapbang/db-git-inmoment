SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[DeleteEmailQueueEntry] (@entryId INT)
AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		DECLARE @attachmentId INT
		SELECT @attachmentId = attachmentObjectId FROM EmailQueue WHERE objectId = @entryId

		DELETE FROM EmailQueue WHERE objectId = @entryId

		IF @attachmentId IS NOT NULL
		BEGIN
--			DELETE FROM Transcription WHERE objectId = (SELECT transcriptionObjectId FROM BinaryContent WHERE objectId = @attachmentId)
			DELETE FROM BinaryContent WHERE objectId = @attachmentId
		END

		COMMIT
	END TRY
	BEGIN CATCH
		DECLARE @errorMessage NVARCHAR(4000), @errorSeverity INT
		SELECT @errorSeverity = ERROR_SEVERITY(), @errorMessage = ERROR_MESSAGE()
		ROLLBACK
		RAISERROR(@errorMessage, @errorSeverity, 1)
	END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
