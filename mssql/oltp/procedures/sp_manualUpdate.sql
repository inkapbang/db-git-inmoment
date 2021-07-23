SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure sp_manualUpdate

AS


PRINT '
SELECT
		*
FROM
		SurveyResponse
WHERE
		objectId IN ( 163027544, 162726608, 162629673 )


/********************  Manual Update  ********************


BEGIN TRAN




UPDATE	
SET		
WHERE	




ROLLBACK TRAN


COMMIT TRAN



***********************************************************/		
'
			
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
