SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__UserAccount_upd2] ON [dbo].[UserAccount] FOR UPDATE 
AS BEGIN 
 DECLARE @RLICHANGES VARCHAR(4000)
 SET @RLICHANGES = ''
 IF UPDATE([enabled]) SET @RLICHANGES=@RLICHANGES+'loginStatus,';
 IF UPDATE([externalId]) SET @RLICHANGES=@RLICHANGES+'externalId,';
 IF UPDATE([firstName]) SET @RLICHANGES=@RLICHANGES+'givenName,';
 IF UPDATE([email]) SET @RLICHANGES=@RLICHANGES+'mail,';
 IF UPDATE([objectId]) SET @RLICHANGES=@RLICHANGES+'objectId,';
 IF UPDATE([lastName]) SET @RLICHANGES=@RLICHANGES+'sn,';
 IF UPDATE([uuid]) SET @RLICHANGES=@RLICHANGES+'uid,';
 /* Legacy app will update these columns even if there was no value there before on crud operations. We do not want this to be considered a password change.*/
 IF UPDATE([temporaryPasswordExpire]) OR UPDATE([temporaryPassword]) SELECT @RLICHANGES = case when inserted.[temporaryPassword] is not null then @RLICHANGES+'password,' else @RLICHANGES end FROM inserted
 IF UPDATE([temporaryPasswordHash]) SELECT @RLICHANGES = case when inserted.[temporaryPasswordHash] is not null then @RLICHANGES+'passwordHash,' else @RLICHANGES end FROM inserted
 
 IF UPDATE([forcePasswordChange]) SET @RLICHANGES=@RLICHANGES+'pwdReset,';
 IF UPDATE([mindshareEmployee]) SET @RLICHANGES=@RLICHANGES+'corporateEmployee,';
 IF UPDATE([global]) SET @RLICHANGES=@RLICHANGES+'legacyglobal,';
 IF UPDATE([locked]) OR UPDATE([lockoutEnd]) SET @RLICHANGES=@RLICHANGES+'pwdAccountLockedTime,';
 IF UPDATE([localeKey]) SET @RLICHANGES=@RLICHANGES+'locale,';
 IF UPDATE([timezone]) SET @RLICHANGES=@RLICHANGES+'timezonename,';
 /* insert converted pwdAccountLockedTime into log */
 INSERT INTO [rli_con].[RadiantUserAccount2_LOG]
   (RLIBASETABLE,RLICHANGETYPE,RLICHANGES, [loginStatus], [externalId],[givenName],[mail],[objectId],[sn],[uid],[password],[passwordHash],[pwdReset],[corporateEmployee],[legacyglobal],[pwdAccountLockedTime],[locale],[timezonename]) 
   select 'OLTP.dbo.RadiantUserAccount2','update',@RLICHANGES,
    case when inserted.[enabled]=1 then 'active' else 'inactive' end,
    inserted.[externalId],inserted.[firstName],inserted.[email],inserted.[objectId],inserted.[lastName],inserted.[uuid],
    inserted.[temporaryPassword], inserted.[temporaryPasswordHash], 
    case when inserted.[forcePasswordChange]=1 then 'TRUE' else 'FALSE' end, 
    case when inserted.[mindshareEmployee]=1 then 'TRUE' else 'FALSE' end, 
    case when inserted.[global]=1 then 'TRUE' else 'FALSE' end, 
    CASE WHEN inserted.[locked]=1 then CAST('99990101000000.000Z' as VARCHAR(20))
         WHEN inserted.[lockoutEnd] IS NULL then NULL
         ELSE CAST(
                  LTRIM(DATEPART(yyyy,DATEADD(minute, -5, inserted.[lockoutEnd])))+
                  RIGHT('0' + LTRIM(DATEPART(mm,DATEADD(minute, -5, inserted.[lockoutEnd]))), 2)+
                  RIGHT('0' + LTRIM(DATEPART(dd,DATEADD(minute, -5, inserted.[lockoutEnd]))), 2)+
                  RIGHT('0' + LTRIM(DATEPART(hh,DATEADD(minute, -5, inserted.[lockoutEnd]))), 2)+
                  RIGHT('0' + LTRIM(DATEPART(mi,DATEADD(minute, -5, inserted.[lockoutEnd]))), 2)+
                  RIGHT('0' + LTRIM(DATEPART(ss,inserted.[lockoutEnd])), 2)+'.'+
                  LTRIM(DATEPART(ms,inserted.[lockoutEnd]))+'Z' AS VARCHAR(20))
    END, inserted.[localeKey],inserted.[timeZone]
   FROM inserted
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__UserAccount_upd2] ON [dbo].[UserAccount]
GO

GO
