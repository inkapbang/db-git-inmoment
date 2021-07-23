SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Create the procedure
CREATE PROCEDURE [dbo].[usp_admin_PublishTable2]
	@article VARCHAR(100)
AS
BEGIN

	-- Only attempt to publish if this is an OLTP
	IF(1 = (SELECT [oltp] FROM [dbo].[GlobalSettings]))
	BEGIN

		DECLARE @SQLVersion NVARCHAR(max)
		SET @SQLVersion = CONVERT(NVARCHAR(max), SERVERPROPERTY('ProductVersion'))
		
		IF @SQLVersion LIKE '10.50.%' OR @SQLVersion LIKE '13.0.%'
		BEGIN
			-- SQL Server 2008 R2 version of the stored proc
			-- SQL Server 2016 (base or SP1 version of the stored proc)
			IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'syspublications'))
			BEGIN
			
				DECLARE @publication VARCHAR(200);
				SET @publication = ( SELECT DISTINCT TOP 1 Name FROM [dbo].[syspublications] );
				IF(@publication IS NOT NULL)
				BEGIN

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
						INSERT INTO @IsPublishedTable EXEC sp_helpArticle @publication, @article;
					END TRY
					BEGIN CATCH
					END CATCH

					-- Set the output
					IF NOT EXISTS (SELECT * FROM @IsPublishedTable where [article name] = @article)
					BEGIN
						IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[' + CAST(@article as nvarchar(max)) + ']') AND type in (N'U'))
						BEGIN
							PRINT 'Publishing article "' + @article + '" to publication "' + @publication + '"...';
							EXEC dbo.PublishTable @publication, @article;
							PRINT 'Article "' + @article + '" published.';
						END
						ELSE
						BEGIN
							RAISERROR('Failed to publish article "%s": Table does not exist.', 16, 1, @article);
						END
					END
					ELSE
					BEGIN
						PRINT 'Skipped publish article "' + @article + '": Article "' + @article + '" already exists in publication "' + @publication + '".';
					END
				END
				ELSE
				BEGIN
					PRINT 'Skipped publishing article "' + @article + '" because no publication exist for database in use.';
				END
			END
			ELSE
			BEGIN
				PRINT 'Skipped publishing article "' + @article + '" because database is not enabled for replication.';
			END
		END
		ELSE
		BEGIN
			RAISERROR('Unrecognized SQL version: "%s"', 16, 1, @SQLVersion);
		END
	END
	ELSE
	BEGIN
		PRINT 'Skipped publish article "' + @article + '": The current database is not an OLTP.';
	END

	-- USAGE:
		--EXEC [dbo].[usp_admin_PublishTable2] 'Article'
	-- EXAMPLE:
		--EXEC [dbo].[usp_admin_PublishTable2] 'SurveyResponse'
END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
