SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create proc [dbo].[usp_admin_reindexalltablesofflineManual]
as 
DECLARE @TableName varchar(255),
		@nvchCommand nvarchar(4000),
		@myError INT

DECLARE TableCursor CURSOR FOR
SELECT table_name FROM information_schema.tables
WHERE table_type = 'base table'

OPEN TableCursor

FETCH NEXT FROM TableCursor INTO @TableName

WHILE @@FETCH_STATUS = 0
BEGIN

if @tableName  in ( 
'binarycontent','emailqueue',
'promptevent','sysdiagrams','systemencryptionkey','signup','signupproperties','dtproperties')
--if @tableName ='surveyresponseanswer'
begin
PRINT @TableName

--Build reindex statments

select @nvchCommand ='begin try'+char(13)+
'ALTER INDEX ALL ON ' + @TableName +
' REBUILD WITH ( SORT_IN_TEMPDB = On,ONLINE=Off)'+char(13)+
'end try'+char(13)+
'BEGIN CATCH'+CHAR(13)+
' Select '''+@tablename+''', ERROR_NUMBER() AS ErrorNumber,'+CHAR(13)+
'       ERROR_SEVERITY() AS ErrorSeverity,'+CHAR(13)+
'       ERROR_STATE() AS ErrorState,'+CHAR(13)+
'       ERROR_PROCEDURE() AS ErrorProcedure,'+CHAR(13)+
'       ERROR_LINE() AS ErrorLine,'+CHAR(13)+
'       ERROR_MESSAGE() AS ErrorMessage'+CHAR(13)+
'END CATCH'


--PRINT @nvchCommand

 --execute the statement.
EXEC sp_executesql @nvchCommand

end--while
FETCH NEXT FROM TableCursor INTO @TableName
END--if

CLOSE TableCursor

DEALLOCATE TableCursor

return

--exec usp_admin_reindexalltablesofflineManual]
--
--ALTER INDEX ALL ON dbo.surveyresponseanswer
--REBUILD WITH ( SORT_IN_TEMPDB = ON,online=off)
         
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
