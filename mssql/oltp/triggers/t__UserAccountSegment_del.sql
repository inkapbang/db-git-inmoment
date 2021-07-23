SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccountSegment_del] ON [dbo].[UserAccountSegment] FOR DELETE
AS BEGIN
 INSERT INTO [rli_con].[RadiantUserAccount_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[legacysegment],[uid])
   select distinct 'oltp.dbo.RadiantUserAccount','update','legacysegment',rua.legacysegment,rua.uid
   FROM [dbo].[RadiantUserAccount] rua
   JOIN deleted on rua.objectId = deleted.userAccountObjectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccountSegment_del] ON [dbo].[UserAccountSegment]
GO

GO
