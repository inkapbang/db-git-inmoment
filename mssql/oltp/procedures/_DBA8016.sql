SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[_DBA8016] 
AS
-- Created: IW

BEGIN

	SET NOCOUNT ON;
	

	DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
	DECLARE	@FileName	varchar(100)
			
	set @FileName='DavidYurman_RedemptionCodes_EUR_Jan2.csv'	
		
	SET		@FileNameBulkInsertStatement	= 'BULK INSERT _RedemptionCodeCustom_Staging   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'' )'

	EXECUTE (@FileNameBulkInsertStatement)	
	
	
	   		
	
End	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
