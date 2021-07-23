SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__PasswordHistory_del] ON [dbo].[PasswordHistory] FOR DELETE
AS BEGIN
 INSERT INTO [rli_con].[RadiantUserAccount_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[password],[passwordChangedDate],[passwordHash],[passwordHistory],[uid])
   select distinct 'oltp.dbo.RadiantUserAccount','update','password,passwordChangedDate,userpassword,passwordHistory',rua.[password],rua.[passwordChangedDate],rua.[passwordHash],rua.[passwordHistory],rua.uid
   FROM [dbo].[RadiantUserAccount] rua
   JOIN deleted on rua.objectId = deleted.userAccountObjectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__PasswordHistory_del] ON [dbo].[PasswordHistory]
GO

GO
