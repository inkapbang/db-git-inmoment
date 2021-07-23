SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[CalculateScore](@scoreType INT, @pointsPossible FLOAT, @answeredPoints FLOAT, @answeredCount INT)
RETURNS FLOAT
AS
BEGIN
	IF @scoreType = 0
		RETURN @answeredPoints
	ELSE IF @scoreType = 1
		RETURN CASE WHEN @pointsPossible > 0.0 then (@answeredPoints / @pointsPossible) * 100.0 ELSE NULL END
	ELSE IF @scoreType = 2
		RETURN CASE WHEN (@answeredCount > 0.0) then @answeredPoints / @answeredCount ELSE NULL END
	
	RETURN NULL
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
