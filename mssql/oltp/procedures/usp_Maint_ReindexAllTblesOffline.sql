SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create Procedure dbo.usp_Maint_ReindexAllTblesOffline
as

print ''
print 'Rebuilding indexes'
print ''
DECLARE @TableName VARCHAR(255)
DECLARE @sql NVARCHAR(500)
DECLARE @fillfactor INT
SET @fillfactor = 96

DECLARE TableCursor CURSOR FOR
select name from sys.tables where type ='U' and schema_id=1 and name not like '[_]%' --and name not like 'surveyresponseanswer' and name not like 'surveyresponsescore'
order by name
OPEN TableCursor
FETCH NEXT FROM TableCursor INTO @TableName
WHILE @@FETCH_STATUS = 0
BEGIN
SET @sql = 'ALTER INDEX ALL ON [' + @TableName + '] REBUILD WITH (Sort_in_tempdb=on,fillfactor=96,maxdop=0)'--= ' + CONVERT(VARCHAR(3),@fillfactor) + ')'
print @sql
EXEC (@sql)

--print @sql
FETCH NEXT FROM TableCursor INTO @TableName
END
CLOSE TableCursor
DEALLOCATE TableCursor;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
