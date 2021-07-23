SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_app_LocationCategoryByType]
	@locationId int,
	@categoryTypeId int,
	@minimumLocationCount int = 0
as
begin
	set nocount on;
	
	declare @categoryId int
	select @categoryId = (select top 1 locationCategoryObjectId from dbo.ufn_app_LocationAncestorCategories (@locationId, @categoryTypeId) order by hierarchyLevel)
	
	while (@categoryId is not null)
	begin
	      declare @parentId int
	      declare @locationCount int
	      declare @name varchar(1000)
	      select
	            top 1
	            @name  = name,
	            @parentId = cat.parentObjectId,
	            @locationCount = (select count(*) from dbo.GetCategoryLocations(cat.objectId))
	      from
	            LocationCategory cat with (nolock)
	      where
	            cat.objectId = @categoryId
	
	      if (@locationCount >= @minimumLocationCount) or (@parentId is null)
	            break
	      else
	            set @categoryId = @parentId
	end
	
	select
	      objectId, name, parentObjectId
	from
	      LocationCategory with (nolock)
	where
	      objectId = @categoryId
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
