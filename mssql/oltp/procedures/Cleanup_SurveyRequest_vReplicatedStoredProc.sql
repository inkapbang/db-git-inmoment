SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[Cleanup_SurveyRequest_vReplicatedStoredProc]
@DT datetime = null
AS

-- ==========================================================
-- Author:		In-Kap Bang
-- Create date: 2015.10.07
-- Description: Purge SurveyRequest/SurveyRequestParam Table
-- ==========================================================


BEGIN

SET NOCOUNT ON;

IF @DT IS NULL SET @DT = GETDATE()


-- Populate Table Variable With IDs To Purge

CREATE TABLE #SR (SRID INT NOT NULL PRIMARY KEY) 

INSERT INTO #SR
SELECT	objectId FROM SurveyRequest WITH (NOLOCK,INDEX(IX_SurveyRequest_purgeTime))
--WHERE	PurgeTime < @DT
WHERE	PurgeTime < dateadd(dd,-90,@DT)--added by Bob Luther 6/29/18 to extend the time 

DECLARE @RequestID int
DECLARE PURGE_CUR CURSOR FOR
SELECT	SRID 
FROM	#SR

OPEN PURGE_CUR
FETCH NEXT FROM PURGE_CUR INTO @RequestID
WHILE @@FETCH_STATUS = 0
BEGIN
	--2016.11.29 IKB Remove Separate DELETE for SurveyRequestParam Table. Relying on CASCADE DELETE
	--2017.02.23 IKB Rolling back to explicit DELETE due to CASCADE DELETE not taking place in subscribers
	DELETE FROM SurveyRequestParam WITH (ROWLOCK) WHERE surveyRequestObjectId = @RequestID
	DELETE FROM SurveyRequest WITH (ROWLOCK) WHERE objectId = @RequestID

	FETCH NEXT FROM PURGE_CUR INTO @RequestID
END

CLOSE PURGE_CUR
DEALLOCATE PURGE_CUR

DROP TABLE #SR

-- Apply Updates To SurveyRequest Table
CREATE TABLE #SR2 (SRID INT NOT NULL PRIMARY KEY)

INSERT INTO #SR2
SELECT objectId FROM SurveyRequest WITH (NOLOCK) WHERE [state] <> 3 and expirationTime < @DT

SET @RequestID = NULL
DECLARE EXP_CUR CURSOR FOR
SELECT	SRID
FROM	#SR2

OPEN EXP_CUR
FETCH NEXT FROM EXP_CUR INTO @RequestID
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE SurveyRequest WITH (ROWLOCK)
		SET [state] = 3,
			failureReason = 7,
			failureMessage = 'Request automatically expired.',
			[version] = [version] + 1
	WHERE	objectId = @RequestID

	FETCH NEXT FROM EXP_CUR INTO @RequestID
END

CLOSE EXP_CUR
DEALLOCATE EXP_CUR
	
DROP TABLE #SR2

RETURN 0


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
