SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.RadiantUserAccount2 (uid,objectId, mail, sn, givenName, loginStatus, externalId, password, passwordChangedDate,passwordHash,legacyorganizationid,legacysegment,passwordHistory,pwdReset,corporateEmployee,legacyglobal,pwdAccountLockedTime,legacyrole,locale,timezonename)  
AS 
select ua.uuid as uid,ua.objectId, ua.email as mail, ua.lastName as sn, ua.firstName as givenName, 
        case when ua.enabled=1 then 'active' else 'inactive' end as loginStatus, 
        ua.externalId,
        case when GETDATE() < temporaryPasswordExpire then temporaryPassword else p.password end as password,
        case when GETDATE() < temporaryPasswordExpire then null else p.date end as passwordChangedDate,
        case when GETDATE() < temporaryPasswordExpire then temporaryPasswordHash else p.passwordHash end as passwordHash,
        stuff((SELECT ' # ' + LTRIM(organizationObjectId)
		FROM OrganizationUserAccount
		WHERE userAccountObjectId = ua.objectId
		FOR XML PATH(''),TYPE).value('.', 'nvarchar(4000)')
		,1,3,'') as legacyorganizationid, 
        (CAST(us.objectId AS NVARCHAR)+'|'+CAST(us.organizationObjectId AS NVARCHAR)+'|'+CAST(us.segmentType AS NVARCHAR(4000))+'|'+CAST(us.segment AS NVARCHAR(4000))) as legacysegment,
        CONVERT(char(23),ph.[date],126)+'Z{RC4}'+ph.[password] as passwordHistory,
        case when ua.forcePasswordChange=1 then 'TRUE' else 'FALSE' end as pwdReset,
        case when ua.mindshareEmployee=1 then 'TRUE' else 'FALSE' end as corporateEmployee,
        case when ua.global=1 then 'TRUE' else 'FALSE' end as legacyglobal,
        case   when ua.locked=1 then CAST('99990101000000.000Z' as VARCHAR(20))
               when ua.lockoutEnd is null then null
	        else CAST(
	               LTRIM(DATEPART(yyyy,DATEADD(minute, -5, ua.lockoutEnd)))+
	               RIGHT('0' + LTRIM(DATEPART(mm,DATEADD(minute, -5, ua.lockoutEnd))), 2)+
	               RIGHT('0' + LTRIM(DATEPART(dd,DATEADD(minute, -5, ua.lockoutEnd))), 2)+
	               RIGHT('0' + LTRIM(DATEPART(hh,DATEADD(minute, -5, ua.lockoutEnd))), 2)+
	               RIGHT('0' + LTRIM(DATEPART(mi,DATEADD(minute, -5, ua.lockoutEnd))), 2)+
	               RIGHT('0' + LTRIM(DATEPART(ss,ua.lockoutEnd)), 2)+'.'+
	               LTRIM(DATEPART(ms,ua.lockoutEnd))+'Z' AS VARCHAR(20))	       
	    end as pwdAccountLockedTime, 
        stuff((SELECT ' # ' + LTRIM(role)
		FROM UserAccountRole
		WHERE userAccountObjectId = ua.objectId
		FOR XML PATH(''),TYPE).value('.', 'nvarchar(500)')
		,1,3,'') as legacyrole,
	REPLACE(ua.localeKey, '_', '-') as locale,
	ua.timeZone as timezonename
        
from UserAccount ua
left join (
        select uas.userAccountObjectId, s.objectId, s.organizationObjectId, stlsv.value as segmentType, slsv.value as segment
        from UserAccountSegment uas
        join Segment s on s.objectId = uas.segmentObjectId
        join OrganizationUserAccount oua on oua.organizationObjectId = s.organizationObjectId and uas.userAccountObjectId = oua.userAccountObjectId
        join LocalizedStringValue slsv on s.nameObjectId = slsv.localizedStringObjectId and slsv.localeKey = 'en_US'
        join SegmentType st on st.objectId = s.segmentTypeObjectId
        join LocalizedStringValue stlsv on st.nameObjectId = stlsv.localizedStringObjectId and stlsv.localeKey = 'en_US'
) us on us.userAccountObjectId = ua.objectId
outer apply [dbo].[RadiantUserAccount_PasswordHistory](ua.objectId) p 
outer apply [dbo].[RadiantUserAccount_PasswordHistory](ua.objectId) ph
where ((ua.objectId = p.userAccountObjectId and p.rn = 1) or p.userAccountObjectId is null)
		and ((ua.objectId = ph.userAccountObjectId and ph.rn <= 11) or ph.userAccountObjectId is null)


 /* TODO: how does radiant insert multivalued attributes? Is it one insert statement with multiple rows?*/
 /* TODO: should uuid come from radiant or be left to database to generate?*/
 /* TODO: should we implement other join tables on create such as segment, segment type */
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
