SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_LocationsInCategoryOfType](@categoryTypeObjectId int)
RETURNS TABLE
AS RETURN
	SELECT DISTINCT 
		p.objectId locationCategoryObjectId,
		p.name locationCategoryName,
		lcl.locationObjectId 
    FROM
        LocationCategory p 
    JOIN
        LocationCategory c 
            ON p.locationCategoryTypeObjectId = @categoryTypeObjectId 
            AND c.leftExtent >= p.leftExtent 
            AND c.rightExtent <= p.rightExtent 
            AND c.rootObjectId = p.rootObjectId 
    JOIN
        LocationCategoryLocation lcl 
            ON c.objectId=lcl.locationCategoryObjectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
