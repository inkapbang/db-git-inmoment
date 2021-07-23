SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure dbo.usp_admin_fix_allIdentitiesInDB
as
declare  @sql nvarchar(4000),@tablename varchar(50),@colname varchar(50),@currentid int,@count int
set @count=0

declare mycursor cursor for
SELECT A.NAME TABLENAME, B.NAME COLNAME,
IDENT_CURRENT(SCHEMA_NAME(schema_id) + '.' + A.name) CURRENT_ID
FROM Sys.tables A INNER JOIN Sys.All_Columns B ON A.OBJECT_ID = B.Object_ID
WHERE A.Type = 'U' and Is_Identity = 1

open mycursor
fetch next from mycursor into @tablename,@colname,@currentid
while @@fetch_status =0
begin
print @tablename--,@colname,@currentid

set @sql='dbcc checkident ('''+@tablename+''',reseed)'
--select @sql
exec sp_executesql @sql

set @count=@count+1
fetch next from mycursor into @tablename,@colname,@currentid
end--while

close mycursor
deallocate mycursor

print cast (@count as varchar) +' Records processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
