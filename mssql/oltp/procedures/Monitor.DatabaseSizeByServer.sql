SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc Monitor.DatabaseSizeByServer
(@server varchar(100), @database varchar(100))
as
declare @cmd nvarchar(2000)
set @cmd = 'exec '+@server+'.'+@database+'.Monitor.DatabaseSize'
exec sp_executesql @cmd
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
