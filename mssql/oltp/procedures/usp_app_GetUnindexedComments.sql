SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_app_GetUnindexedComments](
      @locationCategoryId INT,
      @contextDate DATETIME,
      @periodTypeId INT,
      @intervalCount INT,
      @intervalOffset INT,
      @unstructuredFeedbackModelId INT,
      @numPeriods INT,
      @feedbackChannelId INT
      ) AS 
      BEGIN 
      SET NOCOUNT ON 
      
      DECLARE @beginDate DATETIME
      DECLARE @endDate DATETIME
      
      SELECT
            @beginDate = beginDate ,
            @endDate = endDate
      FROM
            dbo.[ufn_app_PeriodRangesByPeriodValues](@periodTypeId, @contextDate, @intervalCount, @intervalOffset, @numPeriods , DEFAULT);
          
         
            SELECT
            	c.objectId AS commentId,
               c.commentText AS [comment]
            FROM
                  [dbo].[SurveyResponse] sr
            JOIN 
                  [dbo].[GetCategoryLocations](@locationCategoryId) cl
                  ON sr.[locationObjectId] = cl.[locationObjectId]
                  AND sr.[beginDate] BETWEEN @beginDate AND @endDate
                  AND sr.[complete] = 1
                  AND sr.[exclusionReason] = 0
            JOIN 
                  [dbo].[Offer] o
                  ON o.[objectId] = sr.[offerObjectId]
                     AND [channelObjectId] = @feedbackChannelId
            JOIN 
                  [dbo].[SurveyResponseAnswer] sra
                  ON sr.[objectId] = sra.[surveyResponseObjectId]
            JOIN 
                  [dbo].[UnstructuredFeedbackCommentField] ufc
                  ON ufc.[dataFieldObjectId] = sra.[dataFieldObjectId]
                     AND ufc.[unstructuredFeedbackModelObjectId] = @unstructuredFeedbackModelId
            JOIN 
                  [dbo].[Comment] c
                  ON c.[surveyResponseAnswerObjectId] = sra.[objectId]
		  WHERE c.commentTextLengthWords < 0
           
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
