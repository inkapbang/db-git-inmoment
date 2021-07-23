SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create proc SetSurveyBeginTimeToBaseDate
as begin
UPDATE SurveyResponse SET
beginTime = CAST(0 AS DATETIME) + CAST(beginTime AS BINARY(4))
where not CAST(FLOOR(CAST(beginTime AS FLOAT)) AS DATETIME) = CAST(0 as DATETIME)
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
