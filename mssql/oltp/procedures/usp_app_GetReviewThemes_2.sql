SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_app_GetReviewThemes_2](
	@locationId INT,
	@unstructuredFeedbackModelId INT,
	@beginDate DATETIME,
	@endDate DATETIME
	) AS 
	BEGIN 
	SET NOCOUNT ON 

	DECLARE @feedbackChannelId INT

	SELECT @feedbackChannelId = channelObjectId
	FROM dbo.UnstructuredFeedbackModel
	WHERE objectId = @unstructuredFeedbackModelId;
   
	WITH IndexedComments AS (   
	SELECT
		c.objectId commentId,
		sr.objectId responseId,
		sr.reviewOptIn reviewOptIn,
		ufc.dataFieldObjectId dataFieldId
	FROM
		[dbo].[SurveyResponse] sr
	JOIN 
		[dbo].[Offer] o
		ON o.[objectId] = sr.[offerObjectId]
		  AND [channelObjectId] = @feedbackChannelId
		  AND sr.[locationObjectId] = @locationId
		  AND sr.[beginDate] BETWEEN @beginDate AND @endDate
		  AND sr.[complete] = 1
		  AND sr.[exclusionReason] = 0
		  AND sr.reviewOptIn = 1
	JOIN 
		[dbo].[SurveyResponseAnswer] sra
		ON sr.[objectId] = sra.[surveyResponseObjectId]
	JOIN 
		[dbo].[UnstructuredFeedbackCommentField] ufc
		ON ufc.[dataFieldObjectId] = sra.[dataFieldObjectId]
		  AND ufc.[unstructuredFeedbackModelObjectId] = @unstructuredFeedbackModelId
	JOIN
		[dbo].Comment c
		on c.surveyResponseAnswerObjectId = sra.objectId
	where 
		c.commentTextLengthWords > 0
	)
	--SELECT * FROM [IndexedComments]
	, AllTerms
      AS ( SELECT
		ic.responseId,
		ic.dataFieldId,
		ic.reviewOptIn,
		term.[objectId] termId,
		term.[text] termText, 
		ROW_NUMBER() OVER (PARTITION BY ic.responseId, ic.dataFieldId, term.objectId ORDER BY ic.responseId) number,
		[dbo].[TermAnnotation].[sentiment],
		[dbo].[TermAnnotation].[score],
		[dbo].[TermAnnotation].[evidence],
		[dbo].[TermAnnotation].[transcriptionConfidenceLevel] as confidenceLevel,
		ic.[commentId]
           FROM
            [dbo].[Term]
           JOIN 
            [dbo].[TermAnnotation]
            ON [dbo].[Term].[objectId] = [dbo].[TermAnnotation].[termId]
           JOIN 
            IndexedComments ic
            ON [dbo].[TermAnnotation].[commentId] = ic.commentId
         ) 
            -- SELECT * FROM [AllTerms]

,     TermSum
      AS ( SELECT
            termId ,
            termText ,
            sentiment,
            confidenceLevel,
            COUNT(DISTINCT commentId) weight, --SUM(score) weight, --Change back when score is a z-score instead of relative to each comment
            COUNT(DISTINCT commentId) docsContainingTerm
           FROM
            AllTerms
            where number = 1 
            GROUP BY 
            termId,
            termText,
            sentiment,
            confidenceLevel
         ) 
           --  SELECT * FROM TermSum
           --  ORDER BY termId
,       AllTerms1
      AS ( SELECT
            termId id,
            termText ,
            weight,
            docsContainingTerm numComments,
            sentiment,
            confidenceLevel
           FROM
            TermSum 
         ) 
	SELECT TOP 15 * FROM AllTerms1
	ORDER BY numComments desc
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
