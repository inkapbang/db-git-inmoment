SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create PROCEDURE [dbo].[_MnS_DBA7788] 
AS

BEGIN

	SET NOCOUNT ON;
	

	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DBA7788Import') AND type = (N'U'))    DROP TABLE _DBA7788Import
	CREATE TABLE _DBA7788Import
			(
				Old_columnA	varchar(100) )
				

	DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
	DECLARE	@FileName	varchar(100)
			
	set @FileName='ListRemining.csv'	
		
	SET		@FileNameBulkInsertStatement	= 'BULK INSERT _DBA7788Import   	FROM ''c:\tmpUpload\' + @FileName + '''	  WITH ( FIRSTROW = 2, FIELDTERMINATOR = '','' )'

	EXECUTE (@FileNameBulkInsertStatement)	
	
	
	--	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_DBA7788Import ') AND type = (N'U'))    DROP TABLE _DBA7788Import 

	   		
	
End	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
