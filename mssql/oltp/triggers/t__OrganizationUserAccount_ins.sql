SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__OrganizationUserAccount_ins] ON [dbo].[OrganizationUserAccount] FOR INSERT 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[legacyorganizationid],[uid]) 
   select 'oltp.dbo.RadiantUserAccount','insert','legacyorganizationid',inserted.organizationObjectId,ua.uuid
   from inserted
   join UserAccount ua on inserted.userAccountObjectId = ua.objectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__OrganizationUserAccount_ins] ON [dbo].[OrganizationUserAccount]
GO

GO
