SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC [dbo].[usp_app_UpdateLocationCategoryNestedSets](@rootId INT, @offset INT)
AS
BEGIN
      SET NOCOUNT ON;
 
      WITH TwoNumsCTE AS (
            SELECT 1+@offset AS n
            UNION ALL
            SELECT 2+@offset
      ),
      SortPathCTE AS (
            SELECT
                  objectId,
                  0 AS depth,
                  n,
                  CAST(n AS VARBINARY(MAX)) AS sortPath
            FROM
                  dbo.LocationCategory
                  CROSS JOIN TwoNumsCTE
            WHERE
                  objectId = @rootId
 
            UNION ALL
 
            SELECT
                  C.objectId,
                  P.depth + 1,
                  TN.n,
                  P.sortPath + CAST(
                        ROW_NUMBER() OVER(PARTITION BY C.parentObjectId ORDER BY C.name, TN.n)
                        AS BINARY(4))
            FROM
                  SortPathCTE AS P
                  JOIN dbo.LocationCategory AS C
                  ON P.n = 1+@offset
                  AND C.parentObjectId = P.objectId
                  CROSS JOIN TwoNumsCTE AS TN
      ),
      SortCTE AS (
            SELECT
                  objectId,
                  depth,
                  ROW_NUMBER() OVER(ORDER BY sortPath) AS sortVal
            FROM
                  SortPathCTE
      ),
      NestedSetsCTE AS (
            SELECT
                  objectId,
                  depth,
                  MIN(sortVal) AS leftExtent,
                  MAX(sortVal) AS rightExtent
            FROM
                  SortCTE
            GROUP BY
                  objectId, depth
      )
      UPDATE L
      SET
            L.rootObjectId = @rootId,
            L.depth = NS.depth,
            L.leftExtent = NS.leftExtent+@offset,
            L.rightExtent = NS.rightExtent+@offset
      FROM
            LocationCategory L
            JOIN NestedSetsCTE NS
                  ON L.objectId = NS.objectId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
