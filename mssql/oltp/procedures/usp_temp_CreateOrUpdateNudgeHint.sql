SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_temp_CreateOrUpdateNudgeHint] 
	@localeKey varchar(20),
	@trigger nvarchar(4000),
	@hint nvarchar(4000)
as
BEGIN
	IF NOT EXISTS (select [hint] from [dbo].[NudgeHint] where [locale]=@localeKey and [trigger]=@trigger)
		BEGIN
			INSERT INTO [dbo].[NudgeHint]
					   ([trigger]
					   ,[locale]
					   ,[hint])
				 VALUES
					   (@trigger
					   ,@localeKey
					   ,@hint);
		END
	ELSE
		BEGIN
			UPDATE [dbo].[NudgeHint]
			SET
				[hint] = @hint
			WHERE
				[locale]=@localeKey
				and [trigger]=@trigger
		END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
