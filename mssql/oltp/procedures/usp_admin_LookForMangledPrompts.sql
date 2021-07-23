SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure dbo.usp_admin_LookForMangledPrompts
@ascii varchar(25)
as
declare @sql nvarchar(2000),@tblname varchar(50),@colname varchar(50)
--set @ascii=char(142)--226 128 153
set @tblname='prompt'
set @colname='audioscript'

set @sql = 'select o.name Orgname,p.name , '+@colname+' from  prompt p with (nolock) join organization o on o.objectid=p.organizationobjectid where '+@colname+' like ' +char(39) +'%'+ @ascii +'%'+char(39)
--set @sql = 'insert into #res select objectid from '+@tblname+' with (nolock) where '+@colname+' like ' +char(39) +'%'+ @ascii +'%'+char(39)

print @sql
exec sp_executesql @sql
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
