SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--or your curiosity here is the query I came up with....I would just wait for the release if you can since there are not guarantees I got it right


create proc userLoginReport 
  @Orgid int
  , @fromDt datetime
  , @toDt datetime

as 

/*
  usage:
  exec userLoginReport 1318, '2017-07-31', '2017-08-06'
  
  */

set nocount on

select 
   a.userAccountObjectId, a.email, u.firstName, u.lastName
   ,count(1) loginCount
   ,max(a.timestamp) lastLoginTime
from AccessEventLog a 
join UserAccount u on a.userAccountObjectId = u.objectId
join OrganizationUserAccount ou on ou.userAccountObjectId = a.userAccountObjectId
where 
   ou.organizationObjectId = @Orgid
   and a.eventType = 0
   and a.timestamp between @fromDt and @toDt
   and u.enabled = 1
group by a.userAccountObjectId, a.email, u.firstName, u.lastName
order by loginCount
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
