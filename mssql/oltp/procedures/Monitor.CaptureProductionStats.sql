SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure Monitor.CaptureProductionStats
as

exec Roy.mindshare.dbo.[usp_admin_ProductionStats_vTad]
exec Roy.warehouse.dbo.[usp_admin_ProductionStats_vTad]
exec PUTWH02.warehouse.dbo.[usp_admin_ProductionStats_vTad]
exec PUTWH03.warehouse.dbo.[usp_admin_ProductionStats_vTad]
exec Treasure.warehouse.dbo.[usp_admin_ProductionStats_vTad]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
