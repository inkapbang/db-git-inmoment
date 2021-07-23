SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_FindLocalizedStringOwner](@localizedStringObjectId int)
AS
BEGIN
	set nocount on

	declare @sql varchar(4000)
	declare @tableName varchar(255)
	declare @tableIdColName varchar(255)
	declare @colName varchar(255)
	declare @objectId int
	declare @TableCols table (
		tableName varchar(255),
		tableIdColName varchar(255),
		colName varchar(255)
	)


insert into @TableCols (tableName, tableIdColName, colName) (
SELECT
 OBJECT_NAME(f.parent_object_id) AS TableName,
 sc.name AS TableIdColName,
 COL_NAME(fc.parent_object_id,
 fc.parent_column_id) AS ColumnName
FROM sys.foreign_keys AS f
 INNER JOIN sys.foreign_key_columns AS fc
  ON f.OBJECT_ID = fc.constraint_object_id
 INNER JOIN sys.columns AS sc
  ON f.parent_object_id = sc.object_id and column_id = 1
WHERE OBJECT_NAME (f.referenced_object_id) = 'LocalizedString'
  AND NOT OBJECT_NAME(f.parent_object_id) = 'LocalizedStringValue'
)

	declare tableColCursor cursor for (
		select tableName, tableIdColName, colName from @TableCols)

	open tableColCursor
	fetch next from tableColCursor into @tableName, @tableIdColName, @colName

	while(@@FETCH_STATUS=0)
	begin
		set @sql='declare valCursor cursor for select '+@tableIdColName+' from '+@tableName+' where '+@colName+' = '+cast(@localizedStringObjectId as varchar)
		--print @sql
		exec (@sql)

		open valCursor
		fetch next from valCursor into @objectId
		
		while(@@FETCH_STATUS=0)
		begin
			if @objectId > 0
			begin
				print('Found LocalizedString with Id = '+cast(@localizedStringObjectId as varchar)+' in table '+@tableName+'.'+@colName+' where objectId='+cast(@objectId as varchar))
				set @sql='select * from '+@tableName+' where objectId = '+cast(@objectId as varchar)
				--print @sql
				exec(@sql)
			end

			fetch next from valCursor into @objectId
		end
		close valCursor
		deallocate valCursor
		fetch next from tableColCursor into @tableName, @tableIdColName, @colName
	end
	close tableColCursor
	deallocate tableColCursor
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
