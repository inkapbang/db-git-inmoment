SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE Procedure SurveyRequestParam_FtpFileFormat_PostSSISUpdate
CREATE  Procedure SurveyRequestParam_FtpFileFormat_PostSSISUpdate
AS
/**************************  Survey Request Post 3rd Attempt Convert To Web - Time Warner  **************************

	Originally Requested by Paul Pratt, Eli Fillmore, Eric Deitz
	Contributions by Will Frazier, Stephen Gowdey

	
	History
		7.16.2013	Tad Peterson
			-- initial creation
		8.8.2013	Tad Peterson
			-- uses version to flag as processed
			

********************************************************************************************************************/
SET NOCOUNT ON


-- Updates SurveyRequest Table
UPDATE	t10
SET		t10.version = 1
FROM
		SurveyRequest	t10
	JOIN
		##SurveyRequestParam_FtpFileFormat	t20
			ON t10.objectId = SurveyRequestObjectId




-- Tests Stored Procedure
--EXEC SurveyRequestParam_FtpFileFormat_PostSSISUpdate
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
