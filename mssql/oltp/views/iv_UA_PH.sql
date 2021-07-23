SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view dbo.iv_UA_PH 
with schemabinding
as 
select	ua.objectId as userAccountObjectId,
		ua.uuid,
		ph.objectId as objectId,
		ph.password,
		ph.date,
		ph.passwordHash
from	dbo.UserAccount ua
		inner join dbo.PasswordHistory ph on (ua.objectId = ph.userAccountObjectId)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
