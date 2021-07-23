SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_mcd_LocationOverallSatTopBoxRank]   @locationId INT, -- the location to rank   @contextDate DATETIMEasbegin	exec usp_cust_mcd_LocationRank @locationId, 12173 /* Overall Sat Top 2 */, @contextDateend
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
