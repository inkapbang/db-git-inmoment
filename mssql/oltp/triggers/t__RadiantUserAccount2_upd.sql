SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__RadiantUserAccount2_upd] ON [dbo].[RadiantUserAccount2] INSTEAD OF UPDATE
AS BEGIN
/*objectId,passwordChangedDate,passwordHistory,legacysegment,legacyrole not supported*/
 IF UPDATE([uid])
 BEGIN
  UPDATE [dbo].[UserAccount] set uuid = inserted.uid FROM inserted JOIN deleted on deleted.objectId = inserted.objectId WHERE deleted.uid = UserAccount.uuid
 END
 IF UPDATE([loginStatus])
 BEGIN
  UPDATE [dbo].[UserAccount] set enabled = case when LOWER(inserted.loginStatus)='active' then 1 else 0 end FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([givenName])
 BEGIN
  UPDATE [dbo].[UserAccount] set firstName = inserted.givenName FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([sn])
 BEGIN
  UPDATE [dbo].[UserAccount] set lastName = inserted.sn FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([externalId])
 BEGIN
  UPDATE [dbo].[UserAccount] set externalId = inserted.externalId FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([mail])
 BEGIN
  UPDATE [dbo].[UserAccount] set email = inserted.mail FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([password]) AND UPDATE([passwordHash])
 BEGIN
 /* Remove the temporary password first so that when you insert into password history (which has a trigger that uses view) it will not return the temporary password.*/
  UPDATE ua set temporaryPassword = null, temporaryPasswordExpire = null, temporaryPasswordHash = null, forcePasswordChange = 0
  FROM inserted
  JOIN [dbo].[UserAccount] ua on ua.uuid = inserted.uid
  INSERT INTO [dbo].[PasswordHistory] (userAccountObjectId, password, date, version, passwordHash)
  SELECT distinct ua.objectId, inserted.[password], GETDATE(), 0, inserted.[passwordHash]
  FROM inserted
  JOIN [dbo].[UserAccount] ua on ua.uuid = inserted.uid;
 END
 IF UPDATE([pwdReset])
 BEGIN
  UPDATE [dbo].[UserAccount] set forcePasswordChange = case when UPPER(inserted.pwdReset) = 'TRUE' then 1 else 0 end FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([corporateEmployee])
 BEGIN
  UPDATE [dbo].[UserAccount] set mindshareEmployee = case when UPPER(inserted.corporateEmployee) = 'TRUE' then 1 else 0 end FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([legacyglobal])
 BEGIN
  UPDATE [dbo].[UserAccount] set global = case when UPPER(inserted.legacyglobal) = 'TRUE' then 1 else 0 end FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([pwdAccountLockedTime])
 BEGIN
  UPDATE [dbo].[UserAccount] set
        lockoutEnd = case when inserted.pwdAccountLockedTime like '99990101000000%' then null
                          when inserted.pwdAccountLockedTime is null then null
                          else
                          DATEADD(MILLISECOND, CASE WHEN ISNUMERIC(substring(inserted.pwdAccountLockedTime,16,3))=1 THEN CAST(substring(inserted.pwdAccountLockedTime,16,3) AS INT) ELSE 0 END,
                            DATEADD(SECOND, CAST(substring(inserted.pwdAccountLockedTime,13,2) AS INT),
                                DATEADD(MINUTE, CAST(substring(inserted.pwdAccountLockedTime,11,2) AS INT) + 5,
                                    DATEADD(HOUR, CAST(substring(inserted.pwdAccountLockedTime,9,2) AS INT),
                                        DATEADD(DAY, CAST(substring(inserted.pwdAccountLockedTime,7,2) AS INT) - 1,
                                            DATEADD(MONTH, CAST(substring(inserted.pwdAccountLockedTime,5,2) AS INT) - 1,
                                                DATEADD(YEAR, CAST(substring(inserted.pwdAccountLockedTime,1,4) AS INT) - 2000, '2000-01-01')
                                            )
                                        )
                                    )
                                )
                            )
                          ) end,
        locked = case when inserted.pwdAccountLockedTime like '99990101000000%' then 1 else 0 end
        FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([legacyorganizationid])
 BEGIN
  INSERT INTO [dbo].[OrganizationUserAccount] (organizationObjectId, userAccountObjectId)
  SELECT distinct inserted.[legacyorganizationid],ua.objectId
  FROM inserted
  JOIN [dbo].[UserAccount] ua on ua.uuid = inserted.uid
  WHERE inserted.[legacyorganizationid] is not null
 END
 IF UPDATE([legacyrole])
 BEGIN
 /*
     DELETE uar
     FROM [dbo].[UserAccountRole] uar
     INNER JOIN [dbo].[UserAccount] ua on ua.objectId = uar.userAccountObjectId
     INNER JOIN inserted on ua.uuid = inserted.uid
     where inserted.legacyrole is null
   */
     INSERT INTO [dbo].[UserAccountRole] (userAccountObjectId, role)
     SELECT distinct ua.objectId,inserted.legacyrole
     FROM inserted
     JOIN [dbo].[UserAccount] ua on ua.uuid = inserted.uid
     where inserted.[legacyrole] is not null
 END
 IF UPDATE([locale])
 BEGIN
     UPDATE [dbo].[UserAccount] set localeKey = REPLACE(inserted.locale, '-', '_') FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
 IF UPDATE([timezonename])
 BEGIN
     UPDATE [dbo].[UserAccount] set timeZone = inserted.timezonename FROM inserted WHERE inserted.uid = UserAccount.uuid
 END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__RadiantUserAccount2_upd] ON [dbo].[RadiantUserAccount2]
GO

GO
