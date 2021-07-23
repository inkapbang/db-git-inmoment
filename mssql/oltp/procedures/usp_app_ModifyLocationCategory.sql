SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- OLTP ONLY


--Update the ModifyLocationCategory proc to delete from UserAccountLocationCategory when deleting a LocationCategory.  The KillLocationCategory trigger is doing this for us, but we want to drop it


CREATE PROCEDURE "dbo"."usp_app_ModifyLocationCategory"(@objectId INT, @name varchar(100), @type INT, @parentId INT, @oldParentId INT, @rootId INT, @oldRootId INT, @orgId INT, @externalId varchar(100), @reviewOptIn bit, @reviewAggregate bit, @reviewUrl varchar(100))
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
					INSERT INTO LocationCategory(name, organizationObjectId, parentObjectId, depth, locationCategoryTypeObjectId, version, timeZone, rootObjectId, leftExtent, rightExtent, externalId, reviewOptIn, reviewAggregate, reviewUrl)
					select @name, organizationObjectId, @parentId, depth+1, @type, 0, timeZone, @rootId, rightExtent+1, rightExtent+2, @externalId, @reviewOptIn, @reviewAggregate, @reviewUrl
						   from LocationCategory
						   where objectId=@rootId
					SET @objectId = SCOPE_IDENTITY();
				END
			-- Add to it's own tree
			ELSE
				BEGIN
					INSERT INTO LocationCategory(name, organizationObjectId, parentObjectId, depth, locationCategoryTypeObjectId, version, timeZone, leftExtent, rightExtent, externalId, reviewOptIn, reviewAggregate, reviewUrl)
						VALUES (@name, @orgId, @parentId, 0, @type, 0, 'America/Denver', 1, 2, @externalId, @reviewOptIn, @reviewAggregate, @reviewUrl);
					SET @objectId = SCOPE_IDENTITY();
					UPDATE LocationCategory set rootObjectId=objectId WHERE objectId=@objectId;
				END  
			
			-- Update the lineage for the inserted node
			EXEC usp_app_updateLineage @objectId
			
			--Add a corresponding value to OrganizationalUnit
			INSERT INTO OrganizationalUnit (version, locationCategoryObjectId) VALUES (0, @objectId);
		END 
	--DELETE
	ELSE IF (@rootId < 0)
		BEGIN
			DELETE FROM OrganizationalUnit WHERE locationCategoryObjectId=@objectId;
			DELETE FROM UserAccountLocationCategory WHERE locationCategoryObjectId = @objectId;
			Delete from LocationCategory where objectId=@objectId
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
    		update LocationCategory set parentObjectId=null, rootObjectId=objectId, name=@name, locationCategoryTypeObjectId=@type, externalId=@externalId, reviewOptIn=@reviewOptIn, reviewAggregate=@reviewAggregate, reviewUrl=@reviewUrl where objectId=@objectId;
	    	
    		-- Update left and right extents to they won't clash with the new tree
			exec usp_app_UpdateLocationCategoryNestedSets @objectId, @newOffset;
			
			-- Assign the LocationCategory to the appropriate parent,root,lineage
			update LocationCategory set parentObjectId=@parentId, rootObjectId=@rootId where objectId=@objectId;
					
			--Update left and right extents of new tree
			IF(@updateTree = 1)
				BEGIN
					exec usp_app_UpdateLocationCategoryNestedSets @rootId, 0;
					SET @updateTree = 0;
				END
			
			-- Fix the left and right extents of the old tree
			IF (@oldRootId != @rootId AND @oldRootId != @objectId)
					exec usp_app_UpdateLocationCategoryNestedSets @oldRootId, 0;
			
			-- Update the lineage for the node and its children
			EXEC usp_app_updateLineage @objectId
		END 
	--UPDATE information
	ELSE
		BEGIN
			update LocationCategory set name=@name, externalId=@externalId, reviewOptIn=@reviewOptIn, reviewAggregate=@reviewAggregate, reviewUrl=@reviewUrl, locationCategoryTypeObjectId=@type where objectId=@objectId;
			SET @updateTree = 0;
		END
	
	--Update left and right extents of new tree
	IF(@updateTree=1 AND @rootId IS NOT NULL)
		BEGIN
			exec usp_app_UpdateLocationCategoryNestedSets @rootId, 0;
		END
	
	SELECT objectId = @objectId;		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
