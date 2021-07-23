SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__PasswordHistory_upd] ON [dbo].[PasswordHistory] FOR UPDATE
AS BEGIN
 INSERT INTO [rli_con].[RadiantUserAccount_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[password],[passwordChangedDate],[passwordHash],[passwordHistory],[uid])
   select distinct 'oltp.dbo.RadiantUserAccount','update','password,passwordChangedDate,userpassword,passwordHistory',rua.[password],rua.[passwordChangedDate],rua.[passwordHash],rua.[passwordHistory],rua.uid
   from inserted
   JOIN [dbo].[RadiantUserAccount] rua on rua.objectId = inserted.userAccountObjectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__PasswordHistory_upd] ON [dbo].[PasswordHistory]
GO

GO
