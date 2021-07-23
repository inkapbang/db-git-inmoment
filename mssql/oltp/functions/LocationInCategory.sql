SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   FUNCTION dbo.LocationInCategory(@locationObjectId INT, @orgObjectId INT, @locationCategoryIdList VARCHAR(250))
RETURNS BIT AS
BEGIN
	DECLARE @count INT
	select @count=count(locationObjectId) from LocationCategoryLocation
	 where
		locationObjectId = @locationObjectId AND
		locationCategoryObjectId in 
			(select LC1.objectId from LocationCategory LC1, 
				(select objectId from LocationCategory 
					inner join split(@locationCategoryIdList, ',') on token=objectId) LC2 
			 where LC1.organizationObjectId = @orgObjectId AND
				(LC1.objectId = LC2.objectId
				 or LC1.lineage like '%/' + cast(LC2.objectId as varchar(10)) + '/%'))
	RETURN CASE @count WHEN 0 THEN 0 ELSE 1 END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
