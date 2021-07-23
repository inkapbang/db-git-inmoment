SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
Create View [Monitor].[Replication]
as
select currentAsOf from dbo.CurrentAsOf
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
