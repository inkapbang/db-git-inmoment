SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccount_del] ON [dbo].[UserAccount] FOR DELETE 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[uid],[objectId]) 
   select 'oltp.dbo.RadiantUserAccount','delete','uid,objectId',deleted.[uuid],deleted.[objectId] from deleted
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccount_del] ON [dbo].[UserAccount]
GO

GO
