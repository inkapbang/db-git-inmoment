SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccount_ins] ON [dbo].[UserAccount] FOR INSERT 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[enabled],[externalId],[firstName],[email],[objectId],[lastName],[uid]) 
   select 'oltp.dbo.RadiantUserAccount','insert',CASE WHEN inserted.[enabled] IS NULL THEN '' ELSE 'enabled,' END + CASE WHEN inserted.[externalId] IS NULL THEN '' ELSE 'externalId,' END + CASE WHEN inserted.[firstName] IS NULL THEN '' ELSE 'firstName,' END + CASE WHEN inserted.[email] IS NULL THEN '' ELSE 'email,' END + CASE WHEN inserted.[objectId] IS NULL THEN '' ELSE 'objectId,' END + CASE WHEN inserted.[lastName] IS NULL THEN '' ELSE 'lastName,' END + CASE WHEN inserted.[uuid] IS NULL THEN '' ELSE 'uid,' END,inserted.[enabled],inserted.[externalId],inserted.[firstName],inserted.[email],inserted.[objectId],inserted.[lastName],inserted.[uuid] from inserted
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccount_ins] ON [dbo].[UserAccount]
GO

GO
