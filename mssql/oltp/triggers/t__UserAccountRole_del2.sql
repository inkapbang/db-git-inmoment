SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccountRole_del2] ON [dbo].[UserAccountRole] FOR DELETE 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[legacyrole],[uid]) 
   select distinct 'OLTP.dbo.RadiantUserAccount2','update','legacyrole',rua.legacyrole,rua.uid
   FROM [dbo].[RadiantUserAccount2] rua
   JOIN deleted on rua.objectId = deleted.userAccountObjectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccountRole_del2] ON [dbo].[UserAccountRole]
GO

GO
