SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER [dbo].[t__RadiantUserAccount2_ins] ON [dbo].[RadiantUserAccount2] INSTEAD OF INSERT 
AS BEGIN 
 INSERT INTO [dbo].[UserAccount] (uuid, email, lastName, firstName, enabled, global, inboxUserFilter, forcePasswordChange, lockoutEnd,locked, smsNotificationType, externalId, mindshareEmployee, exemptFromAutoDisable, xiStatus,localeKey,timeZone, temporaryPassword, temporaryPasswordHash, temporaryPasswordExpire) 
 SELECT distinct ISNULL(inserted.[uid],lower(CONVERT([varchar](36),newid(),0))),inserted.[mail], isnull(inserted.[sn],''), isnull(inserted.[givenName],''), 
        case when LOWER(inserted.[loginStatus])='active' then 1 else 0 end,
        case when UPPER(inserted.[legacyglobal])='TRUE' then 1 else 0 end, 
        /* inboxUserFilter*/ 0, 
        case when UPPER(inserted.[pwdReset])='FALSE' then 0 else 1 end,
 /*lockoutend */ case when inserted.pwdAccountLockedTime like '99990101000000%' then null
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
  /*locked*/ case when inserted.pwdAccountLockedTime like '99990101000000%' then 1 else 0 end,
  /*smsNotificationType*/0, inserted.[externalId], 
  case when UPPER(inserted.[corporateEmployee]) = 'TRUE' then 1 else 0 end, 
  0, 0,
  REPLACE(inserted.locale, '-', '_'),
  inserted.timezonename,
  inserted.[password],
  inserted.[passwordHash],
  case when inserted.[password] is not null then cast('01/01/9999' as datetime) else null end
  
  
 FROM inserted
 
 DECLARE @userAccountObjectId int
 SELECT @userAccountObjectId = (SELECT SCOPE_IDENTITY())
  /*
 INSERT INTO [dbo].[PasswordHistory] (userAccountObjectId, password, date, version, passwordHash) 
 SELECT distinct @userAccountObjectId, inserted.[password], GETDATE(), 0, inserted.[passwordHash]
  FROM inserted
  WHERE inserted.[password] is not null and inserted.[passwordHash] is not null
  */
 INSERT INTO [dbo].[OrganizationUserAccount] (organizationObjectId, userAccountObjectId) 
 SELECT distinct inserted.[legacyorganizationid], @userAccountObjectId
  FROM inserted
  WHERE inserted.[legacyorganizationid] is not null
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[t__RadiantUserAccount2_ins] ON [dbo].[RadiantUserAccount2]
GO

GO
