SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_admin_translate_Phrase]
@phrase nvarchar(max),
@translation nvarchar(max),
@locale nvarchar(15)
as
if @locale in ('en_us','fr_ca','es_mx','ja') 
begin
--select @phrase,@locale
--
declare @count int,@lsvID bigint
set @count=0

declare @res table (localizedstringobjectid bigint,locale nvarchar(15),value nvarchar(max))
insert into @res
select localizedStringObjectId,localeKey,value from localizedstringvalue where value like @phrase

--select * from @res
declare mycursor cursor for 
select localizedstringobjectid from @res

open mycursor
fetch next from mycursor into @lsvid

while @@FETCH_STATUS=0
begin

--select @phrase,@translation,@locale,@lsvid
if not exists(select * from LocalizedStringValue where localizedStringObjectId=@lsvid and localeKey=@locale)
begin
  --insert into localizedstringvalue(localizedstringObjectid,localeKey,value) values(@lsvid,@locale,@translation)
  insert into localizedstringvalue(localizedstringObjectid,localeKey,value,insertOrder) values(@lsvid,@locale,@translation,1)
 end

set @count=@count+1
fetch next from mycursor into @lsvid
end --while
close mycursor
deallocate mycursor

print CAST(@count as varchar)+ ': Records Processed'
end--if

--error Handler
 else print 'Invalid locale...terminating'
--select top 5 * from localizedstringvalue

--------------
--select * from localizedstringvalue where value like 'few times%' and localekey='ja'
--select * from LocalizedStringValue where localizedStringObjectId=151640

--exec dbo.usp_admin_translate_Phrase 'Few times a year',N'年数回','ja'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
