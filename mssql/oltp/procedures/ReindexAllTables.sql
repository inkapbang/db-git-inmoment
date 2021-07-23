SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  PROCEDURE ReindexAllTables
AS
BEGIN
	EXEC SetSystemEnabled 0
	DECLARE @TableName varchar(255)
	DECLARE @myError INT
	
	DECLARE TableCursor CURSOR FOR
	SELECT table_name FROM information_schema.tables
	WHERE table_type = 'base table'
	SET @myError = @@ERROR
	IF @myError != 0 GOTO HANDLE_ERROR
	
	OPEN TableCursor
	SET @myError = @@ERROR
	IF @myError != 0 GOTO HANDLE_ERROR
	
	FETCH NEXT FROM TableCursor INTO @TableName
	SET @myError = @@ERROR
	IF @myError != 0 GOTO HANDLE_ERROR

	WHILE @@FETCH_STATUS = 0
	BEGIN 

		PRINT 'Reindexing ' + @TableName
		DBCC DBREINDEX(@TableName,' ',90)
		SET @myError = @@ERROR
		IF @myError != 0 GOTO HANDLE_ERROR
	
		FETCH NEXT FROM TableCursor INTO @TableName
		SET @myError = @@ERROR
		IF @myError != 0 GOTO HANDLE_ERROR

	END
	
	CLOSE TableCursor
	SET @myError = @@ERROR
	IF @myError != 0 GOTO HANDLE_ERROR
	
	DEALLOCATE TableCursor
	SET @myError = @@ERROR
	IF @myError != 0 GOTO HANDLE_ERROR

	EXEC SetSystemEnabled 1
	RETURN

HANDLE_ERROR:
	EXEC SetSystemEnabled 1
	RAISERROR ('Unable to re-index the %s table', 10, 1, @TableName) WITH LOG, SETERROR
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
