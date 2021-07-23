SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__OrganizationUserAccount_del] ON [dbo].[OrganizationUserAccount] FOR DELETE 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[legacyorganizationid],[uid]) 
   select distinct 'oltp.dbo.RadiantUserAccount','delete','legacyorganizationid',deleted.[organizationObjectId],ua.uuid
   from deleted
   join UserAccount ua on deleted.userAccountObjectId = ua.objectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__OrganizationUserAccount_del] ON [dbo].[OrganizationUserAccount]
GO

GO
