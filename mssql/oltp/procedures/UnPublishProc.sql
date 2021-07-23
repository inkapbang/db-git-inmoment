SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE PROCEDURE UnPublishProc(@publication varchar(100), @procName varchar(100))
CREATE PROCEDURE UnPublishProc(@publication varchar(100), @procName varchar(100))
AS
/******************************  UnPublishProc  ******************************

	This is used to unpublish a stored proc that has been used as a 
	replicated stored proc.
	
	History
		4.22.2013     Tad Peterson
			-- Created; needed a method to remove a stored proc without using
			   the manual process the can lock up the production database.
	
		6.15.2013	Tad Peterson
			-- Added logic and output of processing.


****************************************************************************/

IF EXISTS ( SELECT 1 	FROM syspublications	JOIN sysarticles	ON syspublications.pubid = sysarticles.pubid 	WHERE sysarticles.name = @procName )
BEGIN
	IF EXISTS (	SELECT 1	FROM syspublications	WHERE Name = @publication	)
	BEGIN
	
		PRINT 'UnPublishing procedure "' + @procName + '" from publication "' + @publication + '"...';
			
			-- Verified successful
			EXEC sp_dropsubscription 
				@publication 					= @publication
				, @article 						= @procName
				, @subscriber 					= N'all' 
				, @destination_db 				= N'all'

			-- Verified successful	
			EXEC sp_droparticle 
				@publication 					= @publication 
				, @article 						= @procName 
				, @force_invalidate_snapshot 	= 0
			
		PRINT 'Procedure "' + @procName + '" unpublished.';

		
		IF NOT EXISTS ( SELECT 1 	FROM syspublications	JOIN sysarticles	ON syspublications.pubid = sysarticles.pubid 	WHERE sysarticles.name = @procName )
		BEGIN
			PRINT 'Procedure "' + @procName + '" has been verified as unpublished as well.';
		END
		ELSE
			PRINT 'Procedure "' + @procName + '" was NOT able to be verified as unpublished.';

			
	END
	ELSE
	BEGIN
		RAISERROR('Failed to unpublish Stored Procedure. Publication does not exist.', 16, 1, @publication);
	END
END
ELSE
BEGIN
	PRINT 'Skipped unpublish article "' + @procName + '": Procedure "' + @procName + '" does not exists in publication "' + @publication + '".';
END

	
	
	
	
	
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
