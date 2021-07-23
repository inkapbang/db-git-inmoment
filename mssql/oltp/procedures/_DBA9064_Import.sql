SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[_DBA9064_Import] 
AS

BEGIN

	SET NOCOUNT ON;
	

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_NudgeImport') AND type = (N'U'))    
	DROP TABLE _NudgeImport
	CREATE TABLE _NudgeImport
			(
				old_trigger	varchar(50),
				new_trigger varchar(50),
				localeKey varchar(2))
				

	DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
	DECLARE	@FileName	varchar(100)
			
	set @FileName='DBA9064Import.csv'	
		
	SET		@FileNameBulkInsertStatement	= 'BULK INSERT _NudgeImport	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = ''|'' )'

	EXECUTE (@FileNameBulkInsertStatement)	
   		
	
End	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
