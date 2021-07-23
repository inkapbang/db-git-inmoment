SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_automation_concatenate_clientType](@webServiceClientObjectId INT)
RETURNS VARCHAR(128)
AS
BEGIN
	
	DECLARE @s AS VARCHAR(MAX);
    SELECT @s = ISNULL(@s + ',', '') + CONVERT(VARCHAR(10),clientType) FROM WebServiceClientType WHERE webServiceClientObjectId = 1;
	RETURN @s
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
