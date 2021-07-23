SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[_DBA6619GE] 
AS
-- Created: IW , Replace employee code 

BEGIN

	SET NOCOUNT ON;
	

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DBA6619Import') AND type = (N'U')) 
   DROP TABLE _DBA6619Import
	CREATE TABLE _DBA6619Import
			(
				responseId	int)

	DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
	DECLARE	@FileName	varchar(100)
			
	set @FileName='DBA6619_LocationId.csv'	
		
	SET		@FileNameBulkInsertStatement	= 'BULK INSERT _DBA6619Import   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'

	EXECUTE (@FileNameBulkInsertStatement)	
	
	
	
	   		
	
End	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
