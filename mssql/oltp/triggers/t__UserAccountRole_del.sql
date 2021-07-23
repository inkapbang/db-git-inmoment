SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccountRole_del] ON [dbo].[UserAccountRole] FOR DELETE 
AS BEGIN 
 INSERT INTO [dbo].[UserAccountRole_LOG]
   (BASETABLE,CHANGETYPE,[CHANGES],[userAccountObjectId],[Role]) 
   select 'oltp.dbo.UserAccountRole','delete','UserAccountObjectid,Role',deleted.[userAccountObjectId],deleted.[Role] from deleted
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccountRole_del] ON [dbo].[UserAccountRole]
GO

GO
