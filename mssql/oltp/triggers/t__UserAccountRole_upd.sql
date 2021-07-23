SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccountRole_upd] ON [dbo].[UserAccountRole] FOR UPDATE 
AS BEGIN 
 DECLARE @CHANGES VARCHAR(4000)
 SET @CHANGES = ''
 IF UPDATE([Role]) SET @CHANGES=@CHANGES+'Role,';
 
 INSERT INTO [dbo].[UserAccountRole_LOG]
   (BASETABLE,
   CHANGETYPE,
   CHANGES,
   [userAccountObjectId],
   [Role])
   select 
   'oltp.dbo.UserAccountRole',
   'update',
   @CHANGES,
   inserted.[userAccountObjectId],
   inserted.[Role]
 FROM inserted
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccountRole_upd] ON [dbo].[UserAccountRole]
GO

GO
