SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure Update_Page_BenchmarkType
AS
UPDATE Page SET benchmarkType = CAST(benchmarkEnabled AS TINYINT) WHERE benchmarkType IS NULL AND benchmarkEnabled IS NOT NULL
UPDATE Page SET benchmarkType = 0 WHERE benchmarkType IS NULL AND benchmarkEnabled IS NULL
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
