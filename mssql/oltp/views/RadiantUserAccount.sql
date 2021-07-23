SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW dbo.RadiantUserAccount (uid,objectId, email, lastName, firstName, enabled, externalId, password, passwordChangedDate,passwordHash,legacyorganizationid,legacysegment,passwordHistory)  
AS 
select ua.uuid as uid,ua.objectId, ua.email, ua.lastName, ua.firstName, ua.enabled, ua.externalId,
        case when GETDATE() < temporaryPasswordExpire then temporaryPassword else p.password end as password,
        case when GETDATE() < temporaryPasswordExpire or ua.forcePasswordChange = 1 then null else p.date end as passwordChangedDate,
        case when GETDATE() < temporaryPasswordExpire then temporaryPasswordHash else p.passwordHash end as passwordHash,
        oua.organizationObjectId as legacyorganizationid, 
        (CAST(us.objectId AS VARCHAR)+'|'+CAST(us.organizationObjectId AS VARCHAR)+'|'+CAST(us.segmentType AS VARCHAR(4000))+'|'+CAST(us.segment AS VARCHAR(4000))) as legacysegment,
        CONVERT(char(23),ph.[date],126)+'Z{RC4}'+ph.[password] as passwordHistory
from UserAccount ua
left join OrganizationUserAccount oua on oua.userAccountObjectId = ua.objectId
left join Organization o on oua.organizationObjectId = o.objectId
left join (
        select uas.userAccountObjectId, s.objectId, s.organizationObjectId, stlsv.value as segmentType, slsv.value as segment
        from UserAccountSegment uas
        join Segment s on s.objectId = uas.segmentObjectId
        join LocalizedStringValue slsv on s.nameObjectId = slsv.localizedStringObjectId and slsv.localeKey = 'en_US'
        join SegmentType st on st.objectId = s.segmentTypeObjectId
        join LocalizedStringValue stlsv on st.nameObjectId = stlsv.localizedStringObjectId and stlsv.localeKey = 'en_US'
) us on us.userAccountObjectId = ua.objectId and us.organizationObjectId = oua.organizationObjectId
outer apply [dbo].[RadiantUserAccount_PasswordHistory](ua.objectId) p 
outer apply [dbo].[RadiantUserAccount_PasswordHistory](ua.objectId) ph
where o.enabled=1
		and ((ua.objectId = p.userAccountObjectId and p.rn = 1) or p.userAccountObjectId is null)
		and ((ua.objectId = ph.userAccountObjectId and ph.rn <= 11) or ph.userAccountObjectId is null)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
