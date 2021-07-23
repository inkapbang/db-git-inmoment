SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- Create/recreate the proc
CREATE PROCEDURE [usp_admin_WaitForColumnReplication]
	@TableName VARCHAR(100),
	@ColumnName VARCHAR(100),
	@TimeoutSeconds INT
AS
BEGIN
	Declare @SQL VarChar(1000);
	SET @SQL = '' 
	SET @SQL = @SQL + 'DECLARE @index int; ';
	SET @SQL = @SQL + 'SET @index = 0; ';
	SET @SQL = @SQL + 'PRINT ''Waiting up to ' + CAST(@TimeoutSeconds as VARCHAR(100)) + ' second(s) for the [' + @TableName + '].[' + @ColumnName + '] column to be replicated to warehouse...''; ';
	SET @SQL = @SQL + 'WHILE NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N''[dbo].[' + @TableName + ']'') AND name = N''' + @ColumnName + ''') AND @index < ' + CAST(@TimeoutSeconds as VARCHAR(100)) + ' ';
	SET @SQL = @SQL + '		BEGIN ';
	SET @SQL = @SQL + '			WAITFOR DELAY ''00:00:01''; ';
	SET @SQL = @SQL + '			SET @index = @index + 1; ';
	SET @SQL = @SQL + '		END ';
	SET @SQL = @SQL + ' ';
	SET @SQL = @SQL + 'IF @index >= ' + CAST(@TimeoutSeconds as VARCHAR(100)) + ' ';
	SET @SQL = @SQL + '		RAISERROR(''Column "%s" was not replicated to the warehouse before the wait timeout elapsed.'', 16, 1, ''' + @ColumnName + '''); ';
	SET @SQL = @SQL + 'ELSE ';
	SET @SQL = @SQL + '		PRINT ''Column [' + @TableName + '].[' + @ColumnName + '] replicated. Total wait time: '' + CAST(@index as VARCHAR(100)) + '' seconds.''; ';
	IF(0 = (SELECT [oltp] FROM [dbo].[GlobalSettings]))
	BEGIN
		EXEC (@SQL);
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
