SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Create the procedure
CREATE PROCEDURE [dbo].[usp_admin_UnPublishProc2]
	@article VARCHAR(100)
AS
BEGIN

	-- Only attempt to publish if this is an OLTP
	IF(1 = (SELECT [oltp] FROM [dbo].[GlobalSettings]))
	BEGIN

		DECLARE @SQLVersion NVARCHAR(max)
		SET @SQLVersion = CONVERT(NVARCHAR(max), SERVERPROPERTY('ProductVersion'))

		IF @SQLVersion LIKE '10.50.%'
		BEGIN
			-- SQL Server 2008 R2 version of the stored proc
			
			DECLARE @publication VARCHAR(200);
			SET @publication = ( SELECT DISTINCT TOP 1 Name FROM [dbo].[syspublications] );
			IF(@publication IS NOT NULL)
			BEGIN

				-- Declare the table variable to hold the results of the 
				-- sp_helpArticle procedure
				DECLARE @IsPublishedProc TABLE (
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
					INSERT INTO @IsPublishedProc EXEC sp_helpArticle @publication, @article;
				END TRY
				BEGIN CATCH
				END CATCH

				-- Set the output
				IF EXISTS (SELECT * FROM @IsPublishedProc where [article name] = @article)
				BEGIN
					IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[' + CAST(@article as nvarchar(max)) + ']') AND type in (N'P', N'PC'))
					BEGIN
						PRINT 'Unpublishing procedure "' + @article + '" from publication "' + @publication + '"...';
						-- Note: The syntax to unpublish a table and proc are identical, so there is no UnpublishProc.
						EXEC [dbo].[UnPublishTable] @publication, @article;
						PRINT 'Procedure "' + @article + '" unpublished.';
					END
					ELSE
					BEGIN
						RAISERROR('Failed to unpublish procedure "%s": Procedure does not exist.', 16, 1, @article);
					END
				END
				ELSE
				BEGIN
					PRINT 'Skipped unpublish procedure "' + @article + '": Procedure "' + @article + '" does not exists in publication "' + @publication + '".';
				END
			END
			ELSE
			BEGIN
				RAISERROR('Failed to publish article "%s": No publication exist for database in use.', 16, 1, @article);
			END
		END
		ELSE
		BEGIN
			RAISERROR('Unrecognized SQL version: "%s"', 16, 1, @SQLVersion);
		END
	END
	ELSE
	BEGIN
		PRINT 'Skipped unpublish article "' + @article + '": The current database is not an OLTP.';
	END


	-- USAGE:
		--EXEC [dbo].[usp_admin_UnPublishProc2] 'Procedure'
	-- EXAMPLE:
		--EXEC [dbo].[usp_admin_UnPublishProc2] 'MyStoredProc'
END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
