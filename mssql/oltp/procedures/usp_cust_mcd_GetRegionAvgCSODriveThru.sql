SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_mcd_GetRegionAvgCSODriveThru]      (@regionId int,	   @contextDate datetime,       @monthsBack int)asbegin	exec usp_cust_mcd_GetRegionAvgCSO @regionId, @contextDate, @monthsBack, 33255 /* Drive Thru */end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
