SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[_DBA9129_Import] 
AS

BEGIN

	SET NOCOUNT ON;
	

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_NudgeImport') AND type = (N'U'))    
	DROP TABLE _NudgeImport
	CREATE TABLE _NudgeImport
			(
				new_trigger	nvarchar(400),
				localeKey varchar(20),
				hint nvarchar(2000),
				)
				

	DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
	DECLARE	@FileName	varchar(100)
			
	set @FileName='DBA9129_Import.csv'	
		
	SET		@FileNameBulkInsertStatement	= 'BULK INSERT _NudgeImport	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'' )'

	EXECUTE (@FileNameBulkInsertStatement)	
   		
	
End	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
