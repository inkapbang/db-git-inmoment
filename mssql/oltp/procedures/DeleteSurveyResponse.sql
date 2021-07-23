SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC [dbo].[DeleteSurveyResponse](@responseId INT)
AS
BEGIN TRY
	PRINT ''
	PRINT '___________________________________________________'
	PRINT 'DELETING SURVEY RESPONSE ' + CAST(@responseId as VARCHAR(15))

	BEGIN TRANSACTION

	DECLARE @answers TABLE(objectId INT PRIMARY KEY, binaryContentObjectId INT)
	INSERT INTO @answers (objectId, binaryContentObjectId)
		SELECT objectId, binaryContentObjectId FROM SurveyResponseAnswer
		WHERE surveyResponseObjectId = @responseId
	PRINT 'Found ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' SurveyResponseAnswer rows'


	--DELETE FROM SurveyResponseAnswerOption WITH (ROWLOCK) WHERE surveyResponseAnswerObjectId IN (SELECT objectId FROM @answers)
	--PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' rows from SurveyResponseAnswerOption'

	DELETE FROM SurveyResponseAnswer WITH (ROWLOCK) WHERE surveyResponseObjectId = @responseId
	PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' rows from SurveyResponseAnswer'

	DELETE FROM BinaryContent WITH (ROWLOCK) WHERE objectId IN (SELECT binaryContentObjectId FROM @answers)
	PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' rows from BinaryContent'

	DELETE FROM SurveyResponseAlert WITH (ROWLOCK) WHERE surveyResponseObjectId = @responseId
	PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' rows from SurveyResponseAlert'

	DELETE FROM SurveyResponseNote WITH (ROWLOCK) WHERE surveyResponseObjectId = @responseId
	PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' rows from SurveyResponseNote'

	DELETE FROM SurveyResponseScore WITH (ROWLOCK) WHERE surveyResponseObjectId = @responseId
	PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' rows from SurveyResponseScore'

	DELETE FROM SurveyResponse WITH (ROWLOCK) WHERE objectId = @responseId
	PRINT 'Deleted ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' rows from SurveyResponse'

	COMMIT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK

	DECLARE @errMsg NVARCHAR(4000), @errSeverity INT
	SELECT @errMsg = ERROR_MESSAGE(), @errSeverity = ERROR_SEVERITY()

	PRINT @errMsg
	PRINT 'Rolling back delete'
	RAISERROR(@errMsg, @errSeverity, 1)
END CATCH
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
