SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Create the procedure
CREATE PROCEDURE [dbo].[usp_admin_PublishProc]
	@publication VARCHAR(100), @article VARCHAR(100)
AS
BEGIN

	DECLARE @SQLVersion NVARCHAR(max)
	SET @SQLVersion = CONVERT(NVARCHAR(max), SERVERPROPERTY('ProductVersion'))

	IF @SQLVersion LIKE '10.50.%'
	BEGIN
		-- SQL Server 2008 R2 version of the stored proc

		-- Set @found = 1 if publication exists, 0 if not
		DECLARE @publicationFound int;
		EXEC sp_helpPublication @publication, @publicationFound OUT;
		IF (@publicationFound = 1)
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
			IF NOT EXISTS (SELECT * FROM @IsPublishedProc where [article name] = @article)
			BEGIN
				IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[' + CAST(@article as nvarchar(max)) + ']') AND type in (N'P', N'PC'))
				BEGIN
					PRINT 'Publishing procedure "' + @article + '" to publication "' + @publication + '"...';
					EXEC [dbo].[PublishProc] @publication, @article;
					PRINT 'Procedure "' + @article + '" published.';
				END
				ELSE
				BEGIN
					RAISERROR('Failed to publish article "%s": Procedure does not exist.', 16, 1, @article);
				END
			END
			ELSE
			BEGIN
				PRINT 'Skipped publish article "' + @article + '": Procedure "' + @article + '" already exists in publication "' + @publication + '".';
			END
		END
		ELSE
		BEGIN
			RAISERROR('Failed to publish article "%s": Publication "%s" does not exist.', 16, 1, @article, @publication);
		END
	END
	ELSE IF @SQLVersion LIKE '9.00.%'
	BEGIN
		-- SQL Server 2005 version of the stored proc

		-- Declare the table variable to hold the results of the 
		-- sp_helpArticle procedure
		DECLARE @IsPublishedDatabase TABLE (
			[pubid]							INT,
			[name]							SYSNAME NULL,
			[restricted]					INT NULL,
			[status]						TINYINT NULL,
			[task]							INT NULL,
			[replication frequency]			TINYINT NULL,
			[synchronization method]		TINYINT NULL,
			[description]					NVARCHAR(255) NULL,
			[immediate_sync]				BIT NULL,
			[enabled_for_internet]			BIT NULL,
			[allow_push]					BIT NULL,
			[allow_pull]					BIT NULL,
			[allow_anonymous]				BIT NULL,
			[independent_agent]				BIT NULL,
			[immediate_sync_ready]			BIT NULL,
			[allow_sync_tran]				BIT NULL,
			[autogen_sync_procs]			BIT NULL,
			[snapshot_jobid]				BINARY(16) NULL,
			[retention]						INT NULL,
			[has subscription]				BIT NULL,
			[allow_queued_tran]				BIT NULL,
			[snapshot_in_defaultfolder]		BIT NULL,
			[alt_snapshot_folder]			NVARCHAR(255) NULL,
			[pre_snapshot_script]			NVARCHAR(255) NULL,
			[post_snapshot_script]			NVARCHAR(255) NULL,
			[compress_snapshot]				BIT NULL,
			[ftp_address]					SYSNAME NULL,
			[ftp_port]						INT NULL,
			[ftp_subdirectory]				NVARCHAR(255) NULL,
			[ftp_login]						SYSNAME NULL,
			[allow_dts]						BIT NULL,
			[allow_subscription_copy]		BIT NULL,
			[centralized_conflicts]			BIT NULL,
			[conflict_retention]			INT NULL,
			[conflict_policy]				INT NULL,
			[queue_type]					INT NULL,
			[backward_comp_level]			INT NULL,
			[publish_to_AD]					BIT NULL,
			[allow_initialize_from_backup]	BIT NULL,
			[replicate_ddl]					INT NULL,
			[enabled_for_p2p]				INT NULL,
			[publish_local_changes_only]	INT NULL,
			[enabled_for_het_sub]			INT NULL
		)

		-- Populate the table with the entry matching the publication and article (if any)
		BEGIN TRY
			INSERT INTO @IsPublishedDatabase 
				EXEC sp_helpPublication;
		END TRY
		BEGIN CATCH
		END CATCH

		-- Set the output
		IF EXISTS (SELECT * FROM @IsPublishedDatabase where [name] = @publication)
		BEGIN

			-- Declare the table variable to hold the results of the 
			-- sp_helpArticle procedure
			DECLARE @IsPublishedProc2 TABLE (
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
				INSERT INTO @IsPublishedProc2 EXEC sp_helpArticle @publication, @article;
			END TRY
			BEGIN CATCH
			END CATCH

			-- Set the output
			IF NOT EXISTS (SELECT * FROM @IsPublishedProc2 where [article name] = @article)
			BEGIN
				IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[' + CAST(@article as nvarchar(max)) + ']') AND type in (N'P', N'PC'))
				BEGIN
					PRINT 'Publishing procedure "' + @article + '" to publication "' + @publication + '"...';
					EXEC [dbo].[PublishProc] @publication, @article;
					PRINT 'Procedure "' + @article + '" published.';
				END
				ELSE
				BEGIN
					RAISERROR('Failed to publish procedure "%s": Procedure does not exist.', 16, 1, @article);
				END
			END
			ELSE
			BEGIN
				PRINT 'Skipped publish procedure "' + @article + '": Procedure "' + @article + '" already exists in publication "' + @publication + '".';
			END
		END
		ELSE
		BEGIN
			RAISERROR('Failed to publish procedure "%s": Publication "%s" does not exist.', 16, 1, @article, @publication);
		END
	END
	ELSE
	BEGIN
		RAISERROR('Unrecognized SQL version: "%s"', 16, 1, @SQLVersion);
	END

	-- USAGE:
		--EXEC [dbo].[usp_admin_PublishProc] 'Publication', 'Procedure'
	-- EXAMPLE:
		--EXEC [dbo].[usp_admin_PublishProc] 'LindaOLTP010111Pub', 'MyStoredProc'
END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
