SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_EnableChangeTracking]
	@tableName VARCHAR(500)
AS
BEGIN

	/* 
		Re-runnable helper method to enable change tracking on a table. Only enables change tracking if the 
		table exists and has not already been enabled for change tracking.
	*/

	DECLARE @SQLString nvarchar(2000);

	/* Build the dynamic SQL */
	SET @SQLString = 
		N'IF EXISTS ( select * from sys.change_tracking_databases ctb join sys.databases db on db.database_id = ctb.database_id where name = db_name() ) ' +
		'BEGIN ' +
		'	PRINT ''Change tracking enabled for database'' ' +
		
		'	IF(0 = (select count(*) from sys.change_tracking_tables ct join sys.tables t on t.object_id = ct.object_id and t.name = ''' + @tableName + ''' join sys.schemas s on s.schema_id = t.schema_id and s.name = ''dbo'')) ' +
		'	BEGIN ' + 
		'		IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = ''dbo'' AND TABLE_NAME = ''' + @tableName + ''') ' + 
		'		BEGIN ' + 
		'			alter table ' + @tableName + ' enable change_tracking; ' + 
		'			PRINT ''Enabled change tracking for [dbo].[' + @tableName + ']''; ' + 
		'		END ' + 
		'		ELSE ' + 
		'		BEGIN ' + 
		'			PRINT ''Skipping enabling change tracking on [dbo].[' + @tableName + '] because it does not exist.''; ' + 
		'		END ' + 
		'	END ' +
		'	ELSE ' + 
		'	BEGIN ' +
		'		PRINT ''Skipping enabling change tracking on [dbo].[' + @tableName + '] because it is already enabled.''; ' + 
		'	END ' +
		'END ' +
		'ELSE BEGIN ' +
		'	PRINT ''Change tracking not enabled for database; skipping'' ' +
		'END '
		
	/* Execute the SQL */
	--print @SQLString
	EXECUTE sp_executesql @SQLString;

	-- USAGE:
		--EXEC [dbo].[usp_admin_EnableChangeTracking] 'TableName'
	-- EXAMPLE:
		--EXEC [dbo].[usp_admin_EnableChangeTracking] 'SurveyResponse'
END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
