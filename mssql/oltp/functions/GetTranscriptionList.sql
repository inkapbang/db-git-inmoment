SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetTranscriptionList] (@surveyResponseObjectId int)
RETURNS nvarchar(max)
AS
BEGIN
 
	DECLARE @results nvarchar(max)
	DECLARE @value nvarchar(max)
	SET @results = N''
	DECLARE transcriptCursor CURSOR LOCAL FOR
		select 
			Comment.commentText 
		from Comment
		join SurveyResponseAnswer sra
			on Comment.surveyResponseAnswerObjectId = sra.objectId
		WHERE 
			sra.surveyResponseObjectId = @surveyResponseObjectId
		order by sra.sequence
	OPEN transcriptCursor
	DECLARE @transcript nvarchar(max)
	DECLARE @delim AS nvarchar(3)
	SET @delim = N''
	FETCH NEXT FROM transcriptCursor INTO @transcript
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @value = @transcript
		IF @value is not null
		BEGIN
			SET @results = @results + @delim + @value
			SET @delim = N' | '
		END
		FETCH NEXT FROM transcriptCursor INTO @transcript
	END
	CLOSE transcriptCursor
	DEALLOCATE transcriptCursor

	RETURN @results
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
