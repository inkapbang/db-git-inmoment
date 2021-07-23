SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* This performs update as we are respecifying the entire mutli value attribute.*/
CREATE TRIGGER [dbo].[t__UserAccountSegment_del2] ON [dbo].[UserAccountSegment] FOR DELETE 
AS BEGIN 
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[legacysegment],[uid]) 
   select distinct 'OLTP.dbo.RadiantUserAccount2','update','legacysegment',rua.legacysegment,rua.uid
   FROM [dbo].[RadiantUserAccount2] rua
   JOIN deleted on rua.objectId = deleted.userAccountObjectId
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccountSegment_del2] ON [dbo].[UserAccountSegment]
GO

GO
