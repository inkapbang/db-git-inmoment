SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_mcd_GetRegionOverallSatAvg]      (@regionId int,	   @contextDate datetime,       @monthsBack int)asbegin	exec usp_cust_mcd_GetRegionOverallSat @regionId, @contextDate, @monthsBack, 13002 /* Overall Sat Average */	end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
