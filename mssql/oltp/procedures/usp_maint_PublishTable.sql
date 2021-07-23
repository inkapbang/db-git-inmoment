SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_maint_PublishTable](@publication varchar(100), @tableName varchar(100))
AS
BEGIN
--exec usp_maint_publishtable 'DoctorMindsharePub','surveyrequest'

exec sp_addarticle 
		@publication='@publication',
		@article='@tableName',
		@source_object='@tableName',
		@status=25
		
	--exec sp_addsubscription 
	--	@publication = @publication, 
	--	@article = @tableName, 
	--	@subscriber = N'all', 
	--	@destination_db = N'all'
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
