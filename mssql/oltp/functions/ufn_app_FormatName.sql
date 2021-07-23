SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/********************************/
CREATE FUNCTION [dbo].[ufn_app_FormatName](@firstName NVARCHAR(100), @lastName NVARCHAR(100), @style INT)
RETURNS NVARCHAR(200) AS
BEGIN
	RETURN
		CASE @style
			WHEN 0 THEN
				coalesce(@lastName + coalesce(', ' + @firstName, ''), @firstName)
			WHEN 1 THEN
				coalesce(@firstName + coalesce(' ' + @lastName, ''), @lastName)
		END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
