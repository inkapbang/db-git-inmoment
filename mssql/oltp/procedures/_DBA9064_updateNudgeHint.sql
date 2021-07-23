SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[_DBA9064_updateNudgeHint] 
AS

BEGIN

	SET NOCOUNT ON;

	-- declare variables
	declare @oldTrigger varchar(50), @newTrigger varchar(50),@localeKey varchar(2)

	
	DECLARE UNudge_Cursor CURSOR FOR SELECT old_trigger,new_trigger,localeKey FROM _NudgeImport
	OPEN UNudge_Cursor;
	
	FETCH NEXT FROM UNudge_Cursor INTO @oldTrigger,@newTrigger,@localeKey
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		IF EXISTS (SELECT 1 from NudgeHint where locale='en' and [TRIGGER]=@oldTrigger) 
			BEGIN
				update NudgeHint set [trigger]=LOWER([trigger]) where locale='en' and [trigger]=@oldTrigger
			END	

		
	    FETCH NEXT FROM UNudge_Cursor INTO @oldTrigger,@newTrigger,@localeKey

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
