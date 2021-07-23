SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[_DBA9129_updateNudgeHint] 
AS

BEGIN

	SET NOCOUNT ON;

	-- declare variables
	declare @newTrigger nvarchar(400),@localeKey varchar(20), @hint nvarchar(2000)
	
	
	DECLARE UNudge_Cursor CURSOR FOR SELECT new_trigger,localeKey,hint FROM _NudgeImport
	OPEN UNudge_Cursor;
	
	FETCH NEXT FROM UNudge_Cursor INTO @newTrigger,@localeKey,@hint
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		IF EXISTS (SELECT 1 from NudgeHint where locale='en' and [TRIGGER]=@newTrigger) 
			BEGIN
				update NudgeHint set hint=@hint where locale='en' and [trigger]=@newTrigger
			END	
		ELSE
			BEGIN
				INSERT INTO NudgeHint VALUES (@newTrigger,@localeKey,@hint)
			END
	
		
	    FETCH NEXT FROM UNudge_Cursor INTO @newTrigger,@localeKey,@hint

	END

	
	CLOSE UNudge_Cursor
	DEALLOCATE UNudge_Cursor

	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
