SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--./Pre-3000_alter_usp_app_ModifyLocationCategory_4.sql
CREATE PROC [dbo].[usp_app_ModifyLocationCategory_4](@objectId INT, @name nvarchar(100), @type INT, @parentId INT, @oldParentId INT, @rootId INT, @oldRootId INT, @orgId INT, @externalId varchar(255), @reviewOptIn bit, @reviewAggregate bit, @reviewUrl varchar(100), @brandId INT)
AS	
BEGIN	
	SET NOCOUNT ON;
	DECLARE @updateTree BIT;
	SET @updateTree = 1;
	
	--INSERT
	if(@objectId IS null) 
		BEGIN
			-- Add to an existing tree
			if(@rootId IS NOT NULL) 
				BEGIN
					INSERT INTO LocationCategory(name, organizationObjectId, parentObjectId, depth, locationCategoryTypeObjectId, version, timeZone, rootObjectId, leftExtent, rightExtent, externalId, reviewOptIn, reviewAggregate, reviewUrl, brandObjectId)
					select @name, organizationObjectId, @parentId, depth+1, @type, 0, timeZone, @rootId, rightExtent+1, rightExtent+2, @externalId, @reviewOptIn, @reviewAggregate, @reviewUrl, @brandId
						   from LocationCategory
						   where objectId=@rootId
					SET @objectId = SCOPE_IDENTITY();
				END
			-- Add to it's own tree
			ELSE
				BEGIN
					DECLARE @randomExtentLim INT = 1000000;
					INSERT INTO LocationCategory(name, organizationObjectId, parentObjectId, depth, locationCategoryTypeObjectId, version, timeZone, leftExtent, rightExtent, externalId, reviewOptIn, reviewAggregate, reviewUrl, brandObjectId)
						VALUES (@name, @orgId, @parentId, 0, @type, 0, 'America/Denver', FLOOR(RAND()*(@randomExtentLim-1)+1), FLOOR(RAND()*(@randomExtentLim-1)+1), @externalId, @reviewOptIn, @reviewAggregate, @reviewUrl, @brandId);
					SET @objectId = SCOPE_IDENTITY();
					UPDATE LocationCategory set rootObjectId=objectId, leftExtent=1, rightExtent=2 WHERE objectId=@objectId;
				END  
			
			-- Update the lineage for the inserted node
			EXEC usp_app_updateLineage_2 @objectId
			
			--Add a corresponding value to OrganizationalUnit
			INSERT INTO OrganizationalUnit (version, locationCategoryObjectId) VALUES (0, @objectId);
		END 
	--DELETE
	ELSE IF (@rootId < 0)
		BEGIN
			DELETE FROM OrganizationalUnit WHERE locationCategoryObjectId=@objectId;
			DELETE FROM UserAccountLocationCategory WHERE locationCategoryObjectId = @objectId;
			DELETE FROM LocationCategory WHERE objectId=@objectId
			SET @rootId=@oldRootId;
		END 
	--UPDATE tree
	ELSE IF (@oldRootId != @rootId OR @oldParentId != @parentId)
		BEGIN
			DECLARE @newOffset INT;
			SET @newOffset=0;
    		
			-- If Move into an existing tree
			IF(@rootId IS NOT null)
				SELECT @newOffset = rightExtent FROM LocationCategory WHERE objectId=@rootId;
			-- Moving to create a new tree
			ELSE
				BEGIN
					SET @updateTree = 0; --Don't need to update the new tree since it is it's own new tree
					SET @rootId = @objectId;
				END
    		
			-- Disconnect from old root and parent and make it it's own tree temporarily
			update LocationCategory set parentObjectId=null, rootObjectId=objectId, name=@name, locationCategoryTypeObjectId=@type, externalId=@externalId, reviewOptIn=@reviewOptIn, reviewAggregate=@reviewAggregate, reviewUrl=@reviewUrl, brandObjectId=@brandId where objectId=@objectId;
	    	
			-- Update left and right extents to they won't clash with the new tree
			exec usp_app_UpdateLocationCategoryNestedSets_2 @objectId, @newOffset;
			
			-- Assign the LocationCategory to the appropriate parent,root,lineage
			update LocationCategory set parentObjectId=@parentId, rootObjectId=@rootId, [version]=([version]+1) where objectId=@objectId;
					
			--Update left and right extents of new tree
			IF(@updateTree = 1)
				BEGIN
					exec usp_app_UpdateLocationCategoryNestedSets_2 @rootId, 0;
					SET @updateTree = 0;
				END
			
			-- Fix the left and right extents of the old tree
			IF (@oldRootId != @rootId AND @oldRootId != @objectId)
					exec usp_app_UpdateLocationCategoryNestedSets_2 @oldRootId, 0;
			
			-- Update the lineage for the node and its children
			EXEC usp_app_updateLineage_2 @objectId
		END 
	--UPDATE information
	ELSE
		BEGIN
			update LocationCategory set name=@name, externalId=@externalId, reviewOptIn=@reviewOptIn, reviewAggregate=@reviewAggregate, reviewUrl=@reviewUrl, locationCategoryTypeObjectId=@type, [version]=([version]+1), brandObjectId=@brandId where objectId=@objectId;
			SET @updateTree = 0;
		END
	
	--Update left and right extents of new tree
	IF(@updateTree=1 AND @rootId IS NOT NULL)
		BEGIN
			exec usp_app_UpdateLocationCategoryNestedSets_2 @rootId, 0;
		END
	
	SELECT objectId = @objectId;		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
