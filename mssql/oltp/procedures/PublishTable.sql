SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[PublishTable](@publication varchar(100), @tableName varchar(100))
AS
BEGIN
	EXEC sp_addarticle
		@publication = @publication,
		@article = @tableName,
		--@source_table = @tableName,
		@source_object = @tableName,
		@destination_table = @tableName,
		@pre_creation_cmd='none',
		@schema_option=0x01,
		@destination_owner ='dbo',
		@source_owner ='dbo',
		@force_invalidate_snapshot = 0,
		@status = 16

	DECLARE subscriberCursor CURSOR LOCAL FOR
		select distinct srvname, dest_db from syssubscriptions
	DECLARE @serverName VARCHAR(100), @destDB VARCHAR(100)
	OPEN subscriberCursor
	FETCH NEXT FROM subscriberCursor INTO @serverName, @destDB
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC sp_addsubscription
			@publication = @publication,
			@subscriber = @serverName,
			@destination_db = @destDB,	
			@sync_type = N'none',
			@article = 'all', 
			@update_mode = N'read only',
			@subscription_type = 'PUSH'		

		FETCH NEXT FROM subscriberCursor INTO @serverName, @destDB
	END
	CLOSE subscriberCursor
	DEALLOCATE subscriberCursor

	EXEC sp_refreshsubscriptions @publication	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
