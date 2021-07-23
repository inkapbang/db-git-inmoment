SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Create the procedure
CREATE PROCEDURE [dbo].[usp_admin_IsPublished]
	@publication VARCHAR(100), @article VARCHAR(100), @isPublished BIT OUTPUT
AS
BEGIN

	-- *************************************************
	--	Utility proc to determine if the article (table)
	--  has been published for replication. Returns
	--  1 if the article is published, and 0 if not.
	-- *************************************************
	
	--Clear the output variable
	SET @isPublished = 0;

	-- Declare the table variable to hold the results of the 
	-- sp_helpArticle procedure
	DECLARE @IsPublishedTable TABLE (
		[article id]					INT,
		[article name]					SYSNAME NULL,
		[base object]					NVARCHAR(257) NULL,
		[destination object]			SYSNAME NULL,
		[synchronization object]		NVARCHAR(257) NULL,
		[type]							SMALLINT NULL,
		[status]						TINYINT NULL,
		[filter]						NVARCHAR(257) NULL,
		[description]					NVARCHAR(255) NULL,
		[insert_command]				NVARCHAR(255) NULL,
		[update_command]				NVARCHAR(255) NULL,
		[delete_command]				NVARCHAR(255) NULL,
		[creation script path]			NVARCHAR(255) NULL,
		[vertical partition]			BIT NULL,
		[pre_creation_cmd]				TINYINT NULL,
		[filter_clause]					NTEXT NULL,
		[schema_option]					BINARY(8) NULL,
		[dest_owner]					SYSNAME NULL,
		[source_owner]					SYSNAME NULL,
		[unqua_source_object]			SYSNAME NULL,
		[sync_object_owner]				SYSNAME NULL,
		[unqualified_sync_object]		SYSNAME NULL,
		[filter_owner]					SYSNAME NULL,
		[unqua_filter]					SYSNAME NULL,
		[auto_identity_range]			INT NULL,
		[publisher_identity_range]		INT NULL,
		[identity_range]				BIGINT NULL,
		[threshold]						BIGINT NULL,
		[identityrangemanagementoption]	INT NULL,
		[fire_triggers_on_snapshot]		BIT NULL
	)

	-- Populate the table with the entry matching the publication and article (if any)
	BEGIN TRY
		INSERT INTO @IsPublishedTable 
			EXEC sp_helpArticle @publication, @article;
	END TRY
	BEGIN CATCH
	END CATCH

	-- Set the output
	IF EXISTS (SELECT * FROM @IsPublishedTable)
		SET @isPublished = 1;

	-- USAGE:
		--DECLARE @isPublished BIT
		--EXEC [dbo].[usp_admin_IsPublished] 'Publication', 'Article', @isPublished OUTPUT
END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
