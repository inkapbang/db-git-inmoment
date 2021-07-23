SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccountSegment_ins] ON [dbo].[UserAccountSegment] FOR INSERT
AS BEGIN
 INSERT INTO [rli_con].[RadiantUserAccount_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[legacysegment],[uid])
   select distinct 'oltp.dbo.RadiantUserAccount','update','legacysegment',rua.legacysegment,rua.uid
   FROM [dbo].[RadiantUserAccount] rua
   JOIN inserted on rua.objectId = inserted.userAccountObjectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccountSegment_ins] ON [dbo].[UserAccountSegment]
GO

GO
