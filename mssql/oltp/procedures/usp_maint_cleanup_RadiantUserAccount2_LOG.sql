SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_maint_cleanup_RadiantUserAccount2_LOG]
@CutoffNumDay INT = 60

AS

SET NOCOUNT ON;


IF @CutoffNumDay IS NULL OR @CutoffNumDay <= 0
BEGIN
    PRINT '@CutoffNumDay cannot be null or zero or negative value.'
    RETURN 1
END

-- Determine cuttoff date using @CutoffNumDay
DECLARE @CutoffTimestamp DATE
SELECT @CutoffTimestamp = DATEADD(day, -1 * @CutoffNumDay, GETDATE())

-- Open cursor to delete row by row
DECLARE @ID_TO_PURGE INT
DECLARE RLI_PURGE_CUR CURSOR FOR
SELECT	RLICHANGEID
FROM	[rli_con].[RadiantUserAccount2_LOG]
WHERE	RLICHANGETIME < @CutoffTimestamp
ORDER BY RLICHANGEID

OPEN RLI_PURGE_CUR
FETCH NEXT FROM RLI_PURGE_CUR INTO @ID_TO_PURGE
WHILE @@FETCH_STATUS = 0
BEGIN
	DELETE FROM [rli_con].[RadiantUserAccount2_LOG] WHERE RLICHANGEID = @ID_TO_PURGE
	FETCH NEXT FROM RLI_PURGE_CUR INTO @ID_TO_PURGE
END

CLOSE RLI_PURGE_CUR
DEALLOCATE RLI_PURGE_CUR

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
