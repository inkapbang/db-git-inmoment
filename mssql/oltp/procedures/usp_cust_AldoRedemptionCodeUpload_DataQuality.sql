SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_cust_AldoRedemptionCodeUpload_DataQuality]
AS
	
-- =============================================
-- Author:		Bailey Hu
-- Create date: 2016.07.27
-- Description:	Data quality checks for the automated Aldo redemption code upload
-- =============================================

--OrgID,RedemptionCode,Market,StartDate,EndDate


-- 1. Check file only contains aldo org id
-- select * from _RedemptionCodeCustom_Staging where  OrganizationObjectId <> 1656
update _RedemptionCodeCustom_Staging set error = isnull(error,'') + 'OrgID: Not allowed. ' where  OrganizationObjectId <> 1656

-- 2. Org id is legit
-- select organizationobjectid from _RedemptionCodeCustom_Staging r left join organization o with (nolock) on r.organizationobjectid = o.objectid where o.objectid is null 
update r set error = isnull(error,'') + 'OrgID: Non-legit. ' from _RedemptionCodeCustom_Staging r left join organization o with (nolock) on r.organizationobjectid = o.objectid where o.objectid is null 

-- 3. Check valid start and end date (values are dates and enddate > startdate)
-- select * from _RedemptionCodeCustom_Staging where cast(usablestartdate as date) > cast(usableenddate as date)
update _RedemptionCodeCustom_Staging set error = isnull(error,'') + 'Start/End Dates: Invalid range. ' where cast(usablestartdate as date) > cast(usableenddate as date)
 
-- 4. Market/Redemption Code strings exceeding 50 characters
-- select * from _RedemptionCodeCustom_Staging where len(RedemptionCode) > 50 or len(market) > 50
update _RedemptionCodeCustom_Staging  set error = isnull(error,'') + 'Market or RedemptionCode exceeds 50 character limit. ' where len(RedemptionCode) > 50 or len(market) > 50
  
-- 5. Null values (orgid, market, code)
-- select * from _RedemptionCodeCustom_Staging where organizationobjectid is null or redemptioncode is null or market is null
 update _RedemptionCodeCustom_Staging  set error = isnull(error,'') + 'Missing Value(s): Check OrgId, Market, RedemptionCode. ' where organizationobjectid is null or redemptioncode is null or market is null

-- 6. Duplicated entries
-- select * from _RedemptionCodeCustom_Staging r inner join (select organizationobjectid, redemptioncode, market from _RedemptionCodeCustom_Staging group by organizationobjectid, redemptioncode, market having count(*) > 1) as dups on r.organizationobjectid = dups.organizationobjectid and r.market = dups.market and r.redemptioncode = dups.redemptioncode
update r set error = isnull(error,'') + 'Duplicate entry: OrgID/Market/RedemptionCode exists more than once. '
from _RedemptionCodeCustom_Staging r inner join 
(select organizationobjectid, redemptioncode, market from _RedemptionCodeCustom_Staging group by organizationobjectid, redemptioncode, market having count(*) > 1) as dups
on r.organizationobjectid = dups.organizationobjectid and r.market = dups.market and r.redemptioncode = dups.redemptioncode

-- 7. Check check entries that have been already used
-- select * from _RedemptionCodeCustom_Staging s inner join redemptioncodecustom r with (nolock) on s.organizationobjectid = r.organizationobjectid and s.market = r.market and s.redemptioncode = r.redemptioncode
update s set error = isnull(error,'') + 'Already exists: OrgID/Market/RedemptionCode combination already in the system. '
from _RedemptionCodeCustom_Staging s inner join redemptioncodecustom r with (nolock) on s.organizationobjectid = r.organizationobjectid and s.market = r.market and s.redemptioncode = r.redemptioncode

--select * from _RedemptionCodeCustom_Staging where error is not null
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
