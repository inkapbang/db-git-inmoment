SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
CREATE TRIGGER [dbo].[t__PasswordHistory_del2] ON [dbo].[PasswordHistory] FOR DELETE 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[password],[passwordChangedDate],[passwordHash],[passwordHistory],[uid]) 
   select distinct 'OLTP.dbo.RadiantUserAccount2','update','password,passwordChangedDate,userpassword,passwordHistory',rua.[password],rua.[passwordChangedDate],rua.[passwordHash],rua.[passwordHistory],rua.uid
   FROM [dbo].[RadiantUserAccount2] rua
   JOIN deleted on rua.objectId = deleted.userAccountObjectId
 END
go

CREATE TRIGGER [dbo].[t__PasswordHistory_upd2] ON [dbo].[PasswordHistory] FOR UPDATE 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[password],[passwordChangedDate],[passwordHash],[passwordHistory],[uid]) 
   select distinct 'OLTP.dbo.RadiantUserAccount2','update','password,passwordChangedDate,userpassword,passwordHistory',rua.[password],rua.[passwordChangedDate],rua.[passwordHash],rua.[passwordHistory],rua.uid 
   from inserted
   JOIN [dbo].[RadiantUserAccount2] rua on rua.objectId = inserted.userAccountObjectId
 END
go
*/

CREATE TRIGGER [dbo].[t__OrganizationUserAccount_ins2] ON [dbo].[OrganizationUserAccount] FOR INSERT 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[legacyorganizationid],[uid]) 
   select distinct 'OLTP.dbo.RadiantUserAccount2','update','legacyorganizationid',rua.legacyorganizationid,rua.uid
   FROM [dbo].[RadiantUserAccount2] rua
   JOIN inserted on rua.objectId = inserted.userAccountObjectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__OrganizationUserAccount_ins2] ON [dbo].[OrganizationUserAccount]
GO

GO
