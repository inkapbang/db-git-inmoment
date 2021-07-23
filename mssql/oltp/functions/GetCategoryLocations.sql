SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetCategoryLocations](@locationCategoryId int)
RETURNS TABLE
AS
RETURN
WITH LC AS (
      SELECT c.objectId
      FROM LocationCategory p
      JOIN [dbo].[LocationCategory] c
      ON p.[objectId] = @locationCategoryId
      AND c.leftExtent >= p.leftExtent
      AND c.rightExtent <= P.rightExtent
      AND c.rootObjectId = (SELECT rootObjectId FROM LocationCategory WHERE objectId = @locationCategoryId)
)
SELECT DISTINCT(lcl.[locationObjectId]) FROM
[dbo].[LocationCategoryLocation] lcl
JOIN LC
ON lcl.[locationCategoryObjectId] = LC.[objectId]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
