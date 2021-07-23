SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC usp_app_updateLineage(@objectId INT)
AS
		WITH LineagePathCTE AS (
				-- The first select gets the lineage for the passed in objectId.  If it has
				-- a parent then uses the lineageSort from it's parent, otherwise it is it's own parent.
				SELECT
					  convert(varchar(255),coalesce(p.lineageSort, '')+'/') AS lineage,
					  l.objectId,
					  convert(varchar(255),coalesce(p.lineageSort, '')+'/'+convert(varchar(10),l.objectId)+'/') AS childLineage
				FROM
					  dbo.LocationCategory l
				LEFT OUTER JOIN
					LocationCategory p
						ON p.objectId=l.parentObjectId
				WHERE
					  l.objectId = @objectId
	 
				UNION ALL
	 
				--The lineage for C (the child) is the childLineage column from the Parent
				SELECT
					  P.childLineage AS lineage,
					  C.objectId,
					  convert(varchar(255),P.childLineage+convert(varchar(10),C.objectId)+'/') AS childLineage
				FROM
					  LineagePathCTE AS P
					  JOIN dbo.LocationCategory AS C
					  ON P.objectId=C.parentObjectId
		  )
		UPDATE L
		  SET
				L.lineage = LP.lineage
		  FROM
				LocationCategory L
				JOIN LineagePathCTE LP
					  ON L.objectId = LP.objectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
