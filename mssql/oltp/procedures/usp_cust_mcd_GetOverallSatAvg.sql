SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_mcd_GetOverallSatAvg]
      (@locationId int,
	   @contextDate datetime,
       @monthsBack int)
as
begin
	exec usp_cust_mcd_GetOverallSat @locationId, @contextDate, @monthsBack, 12342 /* Overall Sat Average */	
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
