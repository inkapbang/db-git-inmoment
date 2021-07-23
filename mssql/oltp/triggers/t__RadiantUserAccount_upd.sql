SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__RadiantUserAccount_upd] ON [dbo].[RadiantUserAccount] INSTEAD OF UPDATE 
AS BEGIN 
 /* UserAccount Properties */
 IF UPDATE([firstName])
 BEGIN
  UPDATE [dbo].[UserAccount] set firstName = inserted.firstName FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([lastName])
 BEGIN
  UPDATE [dbo].[UserAccount] set lastName = inserted.lastName FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([externalId])
 BEGIN
  UPDATE [dbo].[UserAccount] set externalId = inserted.externalId FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([email])
 BEGIN
  UPDATE [dbo].[UserAccount] set email = inserted.email FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 /* Password Properties */
 IF UPDATE([password]) AND UPDATE([passwordHash])
 BEGIN
  INSERT INTO [dbo].[PasswordHistory] (userAccountObjectId, password, date, version, passwordHash) 
  SELECT distinct ua.objectId, inserted.[password], GETDATE(), 0, inserted.[passwordHash]
  FROM inserted 
  JOIN [dbo].[UserAccount] ua on ua.uuid = inserted.uid;
  UPDATE ua set temporaryPassword = null, temporaryPasswordExpire = null, temporaryPasswordHash = null, forcePasswordChange = 0
  FROM inserted
  JOIN [dbo].[UserAccount] ua on ua.uuid = inserted.uid
 END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__RadiantUserAccount_upd] ON [dbo].[RadiantUserAccount]
GO

GO
