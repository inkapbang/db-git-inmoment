SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create PROCEDURE [dbo].[I18nLocalizedString](@value nvarchar(4000), @prevValue nvarchar(4000), @tableName varchar(4000), @columnName varchar(4000), @localeCode varchar(4000))
AS
BEGIN	
	declare @objectId int
	declare @localizedStringObjectId int
	declare @sql nvarchar(4000)
	
	set nocount on
	set @sql='declare rowCursor cursor for select lsv.localizedStringObjectId from ' + @tableName + ' aka join LocalizedString ls on aka.' + @columnName + '= ls.objectId join LocalizedStringValue lsv on ls.objectId = lsv.localizedStringObjectId where lsv.value = ''' + @prevValue + ''''
	print @sql
	exec (@sql)


	open rowCursor
	fetch next from rowCursor into @objectId
	
	while(@@FETCH_STATUS=0)
	begin
		set @sql = 'insert into LocalizedStringValue (localizedStringObjectId, localeKey, value) values  (' + cast(@objectId as varchar) + ', ''' + @localeCode +''', N''' + @value + ''')'
		print @sql
		exec (@sql)
	
		fetch next from rowCursor into @objectId
	end

	close rowCursor
	deallocate rowCursor
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
