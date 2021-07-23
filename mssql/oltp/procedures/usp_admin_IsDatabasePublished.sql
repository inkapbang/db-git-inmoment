SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Create the procedure
CREATE PROCEDURE [dbo].[usp_admin_IsDatabasePublished]
	@isPublished BIT OUTPUT
AS
BEGIN

	-- ***********************************************
	--	Utility proc to determine if the database
	--  has been published for replication. Returns
	--  1 if the database is published, and 0 if not.
	-- ***********************************************
	
	--Clear the output variable
	SET @isPublished = 0;

	-- Declare the table variable to hold the results of the 
	-- sp_helpArticle procedure
	DECLARE @IsPublishedTable TABLE (
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
		INSERT INTO @IsPublishedTable 
			EXEC sp_helpPublication;
	END TRY
	BEGIN CATCH
	END CATCH

	-- Set the output
	IF EXISTS (SELECT * FROM @IsPublishedTable)
		SET @isPublished = 1;

	-- USAGE:
		--DECLARE @isPublished BIT
		--EXEC [dbo].[usp_admin_IsDatabasePublished] 'Publication', 'Article', @isPublished OUTPUT
END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
