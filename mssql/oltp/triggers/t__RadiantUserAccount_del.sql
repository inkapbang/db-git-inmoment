SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__RadiantUserAccount_del] ON [dbo].[RadiantUserAccount] INSTEAD OF DELETE
AS BEGIN
SET NOCOUNT ON
/* noop */
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__RadiantUserAccount_del] ON [dbo].[RadiantUserAccount]
GO

GO
