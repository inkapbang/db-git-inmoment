SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccount_del2] ON [dbo].[UserAccount] FOR DELETE 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[uid],[objectId]) 
   select 'OLTP.dbo.RadiantUserAccount2','delete','uid,objectId',deleted.[uuid],deleted.[objectId] from deleted
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccount_del2] ON [dbo].[UserAccount]
GO

GO
