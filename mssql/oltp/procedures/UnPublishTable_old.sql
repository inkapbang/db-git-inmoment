SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[UnPublishTable_old](@publication varchar(100), @tableName varchar(100))
AS
BEGIN
	exec sp_dropsubscription 
		@publication = @publication, 
		@article = @tableName, 
		@subscriber = N'all', 
		@destination_db = N'all'

	exec sp_droparticle 
		@publication = @publication, 
		@article = @tableName, 
		@force_invalidate_snapshot = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
