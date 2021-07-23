SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
----CREATE PROCEDURE usp_app_RemoveDuplicateResponsesUUID
CREATE PROCEDURE [dbo].[usp_app_RemoveDuplicateResponsesUUID]


AS

/*****************************  usp_app_RemoveDuplicateResponsesUUID  *****************************

	Issue:
		Fixes occasion hicup while porting surveys from MongoDB Cache into OLTP
	Creation Date
		1.25.2013
	Written by
		Tad Peterson as request by BJ Tenny

**************************************************************************************************/

DECLARE @recordCount		int
SET		@recordCount		= ( SELECT SUM(Duplicates) FROM ( SELECT COUNT(1) AS Duplicates 	FROM SurveyResponse WITH (NOLOCK) 	WHERE exclusionReason = 0 AND complete = 1 AND UUID IS NOT NULL 	GROUP BY uuid 	HAVING COUNT(1) > 1) AS t10		)





IF @recordCount = 0
BEGIN
	-- 2015.11.18 IKB Add Print Statement For Counts
	PRINT 'Count Value = '+CONVERT(VARCHAR(50),@recordCount)	
	RETURN
	
END




IF @recordCount > 0 AND @recordCount < 1000
BEGIN
		IF OBJECT_ID('tempdb..##RemoveDuplicateResponsesUUID_Min') IS NOT NULL		DROP TABLE ##RemoveDuplicateResponsesUUID_Min		
		SELECT
				MIN(objectId)		AS SurveyResponseObjectId_Min
				, UUID
		INTO ##RemoveDuplicateResponsesUUID_Min		
		FROM 
				SurveyResponse WITH (NOLOCK) 	
		WHERE 
				exclusionReason = 0 
			AND 
				complete = 1
			AND 
				UUID IS NOT NULL	 	
		GROUP BY 
				UUID 	
		HAVING 
				COUNT(1) > 1


		IF OBJECT_ID('tempdb..##RemoveDuplicateResponsesUUID_Discards') IS NOT NULL		DROP TABLE ##RemoveDuplicateResponsesUUID_Discards		
		SELECT
				objectId		AS SurveyResponseObjectId_Discard
				, t10.UUID
		INTO ##RemoveDuplicateResponsesUUID_Discards		
		FROM 
				SurveyResponse						t10 WITH (NOLOCK)		
			JOIN
				##RemoveDuplicateResponsesUUID_Min	t20
					ON t10.UUID = t20.UUID AND t10.ObjectId != t20.SurveyResponseObjectId_Min
		WHERE 
				exclusionReason = 0 
			AND 
				complete = 1 	
				
				
				


		UPDATE 	t30
		SET 	exclusionReason = 7													-- 7 = delete
		FROM
				SurveyResponse								t30		WITH (NOLOCK)
			JOIN
				##RemoveDuplicateResponsesUUID_Discards		t40
						ON t30.ObjectId = t40.SurveyResponseObjectId_Discard
		WHERE
				t30.ObjectId = t40.SurveyResponseObjectId_Discard					-- This is not neccessary, but best practice to bound queries


		
				
		GOTO PROCESSING_COMPLETE		



END




IF @recordCount >= 1000
BEGIN
				
		IF OBJECT_ID('tempdb..##RemoveDuplicateResponsesUUID_MinCursor') IS NOT NULL		DROP TABLE ##RemoveDuplicateResponsesUUID_MinCursor		
		SELECT
				MIN(objectId)		AS SurveyResponseObjectId_Min
				, UUID
		INTO ##RemoveDuplicateResponsesUUID_MinCursor		
		FROM 
				SurveyResponse WITH (NOLOCK) 	
		WHERE 
				exclusionReason = 0 
			AND 
				complete = 1
			AND 
				UUID IS NOT NULL	 	
		GROUP BY 
				UUID 	
		HAVING 
				COUNT(1) > 1


		IF OBJECT_ID('tempdb..##RemoveDuplicateResponsesUUID_DiscardsCursor') IS NOT NULL		DROP TABLE ##RemoveDuplicateResponsesUUID_DiscardsCursor		
		SELECT
				objectId		AS SurveyResponseObjectId_Discard
				, t10.UUID
		INTO ##RemoveDuplicateResponsesUUID_DiscardsCursor		
		FROM 
				SurveyResponse						t10 WITH (NOLOCK)		
			JOIN
				##RemoveDuplicateResponsesUUID_MinCursor	t20
					ON t10.UUID = t20.UUID AND t10.ObjectId != t20.SurveyResponseObjectId_Min
		WHERE 
				exclusionReason = 0 
			AND 
				complete = 1 	
				
		



		DECLARE @count 				int
				, @srObjectId		int

		SET 	@count = 0

		DECLARE mycursor CURSOR FOR
		SELECT SurveyResponseObjectId_Discard 	FROM ##RemoveDuplicateResponsesUUID_DiscardsCursor

		OPEN mycursor
		FETCH next FROM mycursor INTO @srObjectId

		WHILE @@Fetch_Status = 0
		BEGIN
		
		PRINT cast(@count as varchar)+', '+cast(@srObjectId as varchar)
			
		----******************* W A R N I N G***************************


		UPDATE SurveyResponse WITH (ROWLOCK)
		SET exclusionReason = 7
		WHERE objectId = @srObjectId


		----***********************************************************

		SET @count = @count + 1
		FETCH next FROM mycursor INTO @srObjectId

		END--WHILE
		CLOSE mycursor
		DEALLOCATE mycursor
		PRINT Cast(@count as varchar) +' Records Processed'







		
		GOTO PROCESSING_COMPLETE		

END





PROCESSING_COMPLETE: 
	-- 2015.11.18 IKB Add Print Statement For Counts
	PRINT 'Count Value = '+CONVERT(VARCHAR(50),@recordCount)

	--SELECT *	FROM ##RemoveDuplicateResponsesUUID_Min	
	--SELECT *	FROM ##RemoveDuplicateResponsesUUID_Discards	
	
	IF OBJECT_ID('tempdb..##RemoveDuplicateResponsesUUID_Min') IS NOT NULL				DROP TABLE ##RemoveDuplicateResponsesUUID_Min		
	IF OBJECT_ID('tempdb..##RemoveDuplicateResponsesUUID_Discards') IS NOT NULL			DROP TABLE ##RemoveDuplicateResponsesUUID_Discards		
	IF OBJECT_ID('tempdb..##RemoveDuplicateResponsesUUID_MinCursor') IS NOT NULL		DROP TABLE ##RemoveDuplicateResponsesUUID_MinCursor		
	IF OBJECT_ID('tempdb..##RemoveDuplicateResponsesUUID_DiscardsCursor') IS NOT NULL	DROP TABLE ##RemoveDuplicateResponsesUUID_DiscardsCursor		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
