SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE usp_admin_UpdateStatistics
AS
DECLARE @MyTable VARCHAR(255),
		@sql nvarchar(4000)
DECLARE myCursor
CURSOR FOR
SELECT table_name
FROM information_schema.tables
WHERE table_type = 'base table'
OPEN myCursor
FETCH NEXT FROM myCursor INTO @MyTable
WHILE @@FETCH_STATUS = 0
BEGIN
--PRINT 'Reindexing Table:  ' + @MyTable
select @sql='update statistics ' + @Mytable --+' with sample 50 percent'

print @sql
exec sp_executesql @sql
FETCH NEXT FROM myCursor INTO @MyTable
END
CLOSE myCursor
DEALLOCATE myCursor

--with fullscan
--with sample 50 percent
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
