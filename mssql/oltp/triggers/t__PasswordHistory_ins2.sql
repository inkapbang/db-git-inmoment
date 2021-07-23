SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__PasswordHistory_ins2] ON [dbo].[PasswordHistory] FOR INSERT 
AS BEGIN 
 /* First insert an update to current password */
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[password],[passwordChangedDate],[passwordHash],[uid]) 
   select distinct 'OLTP.dbo.RadiantUserAccount2','update','password,passwordChangedDate,userpassword',rua.[password],rua.[passwordChangedDate],rua.[passwordHash],rua.uid 
   FROM [dbo].[RadiantUserAccount2] rua
   JOIN inserted on rua.objectId = inserted.userAccountObjectId
 /* Second, insert an update on all existing passwordHistory entries. Since the view is a sliding window. */
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[passwordHistory],[uid]) 
   select distinct 'OLTP.dbo.RadiantUserAccount2','update','passwordHistory',rua.[passwordHistory],rua.uid 
   FROM [dbo].[RadiantUserAccount2] rua
   JOIN inserted on rua.objectId = inserted.userAccountObjectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__PasswordHistory_ins2] ON [dbo].[PasswordHistory]
GO

GO
