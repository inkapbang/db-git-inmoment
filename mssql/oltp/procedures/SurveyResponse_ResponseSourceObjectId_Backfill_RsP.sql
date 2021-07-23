SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.SurveyResponse_ResponseSourceObjectId_Backfill_RsP
	@BatchSize	int	= 0
AS

/**********************************  SurveyResponse_ResponseSourceObjectId_Backfill_RsP  **********************************

	Comments
		Request to be re-written as a RsP


		-- Create NC Index for this; 39:53 minutes on DutSql01.Mindshare	
		CREATE NONCLUSTERED INDEX IXNC_SurveyResponse_ResponseSource_Backfill 
		ON SurveyResponse( LocationObjectId, objectId, ResponseSourceObjectId )
		WHERE ResponseSourceObjectId IS NULL
		-- not able to use next line on standard editions
		WITH ( FILLFACTOR = 100, ONLINE = ON, MAXDOP = 1 )


		-- Dropping Index
		DROP INDEX SurveyResponse.IXNC_SurveyResponse_ResponseSource_Backfill




	History
		01.14.2015	Tad Peterson
			-- started and tested on DutSql01.Mindshare


***********************************************************************************************************************/
SET NOCOUNT ON



-- Update statement with BatchSize 
UPDATE
		TOP ( @BatchSize )
		t10								WITH ( ROWLOCK )

SET
		t10.responseSourceObjectId = t40.objectId	

FROM 
		dbo.SurveyResponse 				t10 
	JOIN 
		dbo.Location 					t20  
			ON 
					t20.objectid = t10.locationObjectid 
				AND 
					--this join removes all useless responses and responses already processed.
					t10.responseSourceObjectId IS NULL
	LEFT JOIN 
		dbo.SocialReview 				t30  
			ON t30.surveyResponseObjectId = t10.objectid
	JOIN 
		dbo.ResponseSource 				t40  
			ON 
					t20.organizationObjectId = t40.organizationObjectId 
				AND 
					t40.socialType = 
									CASE 
										WHEN t30.socialType IS NULL OR t30.socialType = 5 OR t30.socialType = 6 THEN 10
										ELSE t30.socialType
									END
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
