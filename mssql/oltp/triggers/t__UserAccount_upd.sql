SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccount_upd] ON [dbo].[UserAccount] FOR UPDATE 
AS BEGIN 
 DECLARE @RLICHANGES VARCHAR(4000)
 SET @RLICHANGES = ''
 IF UPDATE([enabled]) SET @RLICHANGES=@RLICHANGES+'enabled,';IF UPDATE([externalId]) SET @RLICHANGES=@RLICHANGES+'externalId,';IF UPDATE([firstName]) SET @RLICHANGES=@RLICHANGES+'firstName,';IF UPDATE([email]) SET @RLICHANGES=@RLICHANGES+'email,';IF UPDATE([objectId]) SET @RLICHANGES=@RLICHANGES+'objectId,';IF UPDATE([lastName]) SET @RLICHANGES=@RLICHANGES+'lastName,';IF UPDATE([uuid]) SET @RLICHANGES=@RLICHANGES+'uid,'; IF UPDATE([temporaryPasswordExpire]) OR UPDATE([temporaryPassword]) SET @RLICHANGES=@RLICHANGES+'password,';IF UPDATE([forcePasswordChange]) SET @RLICHANGES=@RLICHANGES+'passwordChangedDate,';IF UPDATE([temporaryPasswordHash]) SET @RLICHANGES=@RLICHANGES+'passwordHash,';
 INSERT INTO [rli_con].[RadiantUserAccount_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES,[enabled],[externalId],[firstName],[email],[objectId],[lastName],[uid],[password],[passwordHash]) 
   select 'oltp.dbo.RadiantUserAccount','update',@RLICHANGES,inserted.[enabled],inserted.[externalId],inserted.[firstName],inserted.[email],inserted.[objectId],inserted.[lastName],inserted.[uuid],inserted.[temporaryPassword], inserted.[temporaryPasswordHash] FROM inserted
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccount_upd] ON [dbo].[UserAccount]
GO

GO
