SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[RadiantUserAccount_PasswordHistory](@userAccountObjectId int)
RETURNS TABLE
AS
	RETURN
      SELECT *,ROW_NUMBER() OVER (PARTITION BY userAccountObjectId ORDER BY objectId desc) as rn
      FROM	PasswordHistory
      WHERE userAccountObjectId = @userAccountObjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
