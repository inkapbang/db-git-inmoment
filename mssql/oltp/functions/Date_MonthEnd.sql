SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[Date_MonthEnd](@contextDate DATETIME)
RETURNS DATETIME AS
BEGIN
	RETURN dbo.Date_DayEnd(DATEADD(mm, DATEDIFF(mm, -1, @contextDate),-1)) 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO