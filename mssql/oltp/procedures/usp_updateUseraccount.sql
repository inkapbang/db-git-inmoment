SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure dbo.usp_updateUseraccount 
as
--exec dbo.usp_updateUseraccount 
update useraccount set exemptFromAutoDisable =0 where exemptFromAutoDisable is null
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
