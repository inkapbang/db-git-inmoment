SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure dbo.usp_PopulateAccessEventLog
as
insert into AccessEventLog (timestamp, email, eventType, userAccountObjectId)
(
	select us.sessionDate, ua.email, 0, ua.objectId
	from UserSession us
	inner join UserAccount ua on us.userAccountObjectId = ua.objectId
)


insert into AccessEventLog (timestamp, email, eventType, userAccountObjectId)
(
	select dateadd(mi, 30, us.sessionDate), ua.email, 5, ua.objectId
	from UserSession us
	inner join UserAccount ua on us.userAccountObjectId = ua.objectId
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
