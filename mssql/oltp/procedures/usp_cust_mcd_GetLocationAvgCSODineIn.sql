SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_mcd_GetLocationAvgCSODineIn]      (@locationId int,	   @contextDate datetime,       @monthsBack int)asbegin	exec usp_cust_mcd_GetLocationAvgCSO @locationId, @contextDate, @monthsBack, 33254 /* Dine In */end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
