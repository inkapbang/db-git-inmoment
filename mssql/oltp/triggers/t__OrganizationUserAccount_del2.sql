SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__OrganizationUserAccount_del2] ON [dbo].[OrganizationUserAccount] FOR DELETE 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[legacyorganizationid],[uid]) 
   select distinct 'OLTP.dbo.RadiantUserAccount2','update','legacyorganizationid',rua.legacyorganizationid,rua.uid
   FROM [dbo].[RadiantUserAccount2] rua
   JOIN deleted on rua.objectId = deleted.userAccountObjectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__OrganizationUserAccount_del2] ON [dbo].[OrganizationUserAccount]
GO

GO
