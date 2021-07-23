SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccount_ins2] ON [dbo].[UserAccount] FOR INSERT 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[loginStatus],[externalId],[givenName],[mail],[objectId],[sn],[uid],[pwdReset],[corporateEmployee],[legacyglobal],[locale],[timezonename],[pwdAccountLockedTime]) 
   select 'OLTP.dbo.RadiantUserAccount2','insert',
        CASE WHEN inserted.[enabled] IS NULL THEN '' ELSE 'loginStatus,' END + 
        CASE WHEN inserted.[externalId] IS NULL THEN '' ELSE 'externalId,' END + 
        CASE WHEN inserted.[firstName] IS NULL THEN '' ELSE 'givenName,' END + 
        CASE WHEN inserted.[email] IS NULL THEN '' ELSE 'mail,' END + 
        CASE WHEN inserted.[objectId] IS NULL THEN '' ELSE 'objectId,' END + 
        CASE WHEN inserted.[lastName] IS NULL THEN '' ELSE 'sn,' END + 
        CASE WHEN inserted.[uuid] IS NULL THEN '' ELSE 'uid,' END +
        CASE WHEN inserted.[forcePasswordChange] IS NULL THEN '' ELSE 'pwdReset,' END + 
        CASE WHEN inserted.[mindshareEmployee] IS NULL THEN '' ELSE 'corporateEmployee,' END +
        CASE WHEN inserted.[global] IS NULL THEN '' ELSE 'legacyglobal,' END +
        CASE WHEN inserted.[locked]=1 THEN 'pwdAccountLockedTime,' ELSE '' END,
      CASE WHEN inserted.[enabled]=1 THEN 'TRUE' ELSE 'FALSE' END,
      inserted.[externalId],inserted.[firstName],inserted.[email],inserted.[objectId],inserted.[lastName],inserted.[uuid],
      CASE WHEN inserted.[forcePasswordChange]=1 THEN 'TRUE' ELSE 'FALSE' END,
      CASE WHEN inserted.[mindshareEmployee]=1 THEN 'TRUE' ELSE 'FALSE' END,
      CASE WHEN inserted.[global]=1 THEN 'TRUE' ELSE 'FALSE' END ,
      inserted.[localeKey], 
      inserted.[timeZone],
      CASE WHEN inserted.[locked]=1 then CAST('99990101000000.000Z' as VARCHAR(20)) ELSE NULL END
      
   FROM inserted
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccount_ins2] ON [dbo].[UserAccount]
GO

GO
