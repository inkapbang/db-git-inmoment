SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_mcd_GetAvgCSODriveThru]      (@locationId int,	   @contextDate datetime,       @monthsBack int)asbegin	exec usp_cust_mcd_GetAvgCSO @locationId, @contextDate, @monthsBack, 33255 /* Drive Thru */end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
