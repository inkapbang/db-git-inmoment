SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[_UploadRedemptionCodeCustom_Staging] 
AS


BEGIN

	SET NOCOUNT ON;
	

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_RedemptionCodeCustom_Staging_test') AND type = (N'U'))    DROP TABLE _RedemptionCodeCustom_Staging

-- Create staging table for load 
	CREATE TABLE _RedemptionCodeCustom_Staging_test
	(
		OrganizationObjectId		INT
		, RedemptionCode			VARCHAR(2000)
		, Market				VARCHAR(2000)
		, usableStartDate			datetime
		, usableEndDate			datetime
		)
				

	DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
	DECLARE	@FileName	varchar(100)
			
	set @FileName='DavidYurman_EUR_Jan27_20.csv'	
		
	SET		@FileNameBulkInsertStatement	= 'BULK INSERT _RedemptionCodeCustom_Staging_test  	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'

	EXECUTE (@FileNameBulkInsertStatement)	
	
	
End	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
