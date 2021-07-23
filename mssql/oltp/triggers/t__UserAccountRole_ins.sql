SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccountRole_ins] ON [dbo].[UserAccountRole] FOR INSERT 
AS BEGIN 
 INSERT INTO [dbo].[UserAccountRole_LOG]
   (BASETABLE,CHANGETYPE,CHANGES,[userAccountObjectId],[role]) 
   select 'oltp.dbo.UserAccountRole',
   'insert',
   CASE WHEN inserted.[UserAccountObjectid] IS NULL THEN '' ELSE 'UserAccountObjectid,' END + CASE WHEN inserted.[Role] IS NULL THEN '' ELSE 'Role,' END 
   ,inserted.[userAccountObjectid],inserted.[Role] from inserted

 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccountRole_ins] ON [dbo].[UserAccountRole]
GO

GO
