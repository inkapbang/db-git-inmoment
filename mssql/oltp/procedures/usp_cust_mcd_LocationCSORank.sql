SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_mcd_LocationCSORank]   @locationId INT, -- the location to rank   @contextDate DATETIMEasbegin	exec usp_cust_mcd_LocationRank @locationId, 12139 /* CSO Score */, @contextDateend
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
