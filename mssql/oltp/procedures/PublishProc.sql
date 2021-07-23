SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Doctor Mindshare Only

--CREATE PROCEDURE PublishProc(@publication varchar(100), @procName varchar(100))
CREATE PROCEDURE PublishProc(@publication varchar(100), @procName varchar(100))
AS

/******************************  PublishProc  ******************************

	This is used to publish a stored proc for use as a replicated stored
	proc.

	History
		4.22.2013    Tad Peterson
			-- Removed several previously required variables that
			   are no longer used; legacy variables.

		6.15.2013	Tad Peterson
			-- Added logic and output of processing.

****************************************************************************/

IF NOT EXISTS ( SELECT 1 	FROM syspublications	JOIN sysarticles	ON syspublications.pubid = sysarticles.pubid 	WHERE sysarticles.name = @procName )
BEGIN
	IF EXISTS (	SELECT 1	FROM syspublications	WHERE Name = @publication	)
	BEGIN
		PRINT 'Publishing procedure "' + @procName + '" to publication "' + @publication + '"...';
		
			-- Verified successful
			EXEC sp_addarticle
				@type 							= 'proc exec'
				, @publication 					= @publication
				, @article 						= @procName
				, @source_object 				= @procName
				, @force_invalidate_snapshot 	= 0
			
			-- Verified successful
			EXEC sp_refreshsubscriptions @publication	
		
		
		PRINT 'Procedure "' + @procName + '" published.';
		
		
		IF EXISTS ( SELECT 1 	FROM syspublications	JOIN sysarticles	ON syspublications.pubid = sysarticles.pubid 	WHERE sysarticles.name = @procName )
		BEGIN
			PRINT 'Procedure "' + @procName + '" has been verified as published as well.';
		END
		ELSE
			PRINT 'Procedure "' + @procName + '" was NOT able to be verified as published.';

		
	END
	ELSE
	BEGIN
		RAISERROR('Failed to publish Stored Procedure. Publication does not exist.', 16, 1, @publication);
	END
END
ELSE
BEGIN
	PRINT 'Skipped publish article "' + @procName + '": Procedure "' + @procName + '" already exists in publication "' + @publication + '".';
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
