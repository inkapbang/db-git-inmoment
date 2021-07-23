SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_mcd_GetLocationOverallSatTopBox]      (@locationId int,	   @contextDate datetime,       @monthsBack int)asbegin	exec usp_cust_mcd_GetLocationOverallSat @locationId, @contextDate, @monthsBack, 12173 /* Overall Sat Top 2 */end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
