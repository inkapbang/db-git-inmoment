SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_temp_UpdateParseRuleOptions] 
	@triggerId int
as
BEGIN
	DECLARE @newParseId int
	insert into PromptEventTriggerParseRuleOptions (version) values (0)
	SELECT @newParseId = @@IDENTITY
	UPDATE PromptEventTriggers set parseRuleOptionsObjectId=@newParseId where objectId=@triggerId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
