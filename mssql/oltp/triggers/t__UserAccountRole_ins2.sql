SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccountRole_ins2] ON [dbo].[UserAccountRole] FOR INSERT 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[legacyrole],[uid]) 
   select distinct 'OLTP.dbo.RadiantUserAccount2','update','legacyrole',rua.legacyrole,rua.uid
   FROM [dbo].[RadiantUserAccount2] rua
   JOIN inserted on rua.objectId = inserted.userAccountObjectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccountRole_ins2] ON [dbo].[UserAccountRole]
GO

GO
