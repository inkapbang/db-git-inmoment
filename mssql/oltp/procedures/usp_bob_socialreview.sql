SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--select top 5 * from SocialReview order by objectId desbc

CREATE procedure usp_bob_socialreview
as 
set nocount on 
set arithabort on
--exec usp_bob_socialreview
DECLARE socialReviewCursor CURSOR FOR

--Query to get results (joining SocialReview to SurveyResponse to Location for orgId)
SELECT sr.objectId, l.organizationObjectId FROM  SocialReview sr  ---we don't want to use 'top', just get everything. 
       INNER JOIN SurveyResponse response 
               ON sr.surveyResponseObjectId = response.objectid
       INNER JOIN Location l 
               ON response.locationObjectId = l.objectid 
--WHERE sr.objectid <10000000 and sr.orgId IS NULL;
WHERE sr.orgId IS NULL;                

OPEN socialReviewCursor
DECLARE @surveyReviewObjectId int
DECLARE @orgId int

--save what value needed for input into update query 
FETCH NEXT FROM socialReviewCursor INTO @surveyReviewObjectId, @orgId
WHILE @@FETCH_STATUS = 0
BEGIN

--Update query.
UPDATE SocialReview
SET orgId=@orgId
WHERE objectId=@surveyReviewObjectId

FETCH NEXT FROM socialReviewCursor INTO @surveyReviewObjectId, @orgId
END
CLOSE socialReviewCursor
DEALLOCATE socialReviewCursor
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
