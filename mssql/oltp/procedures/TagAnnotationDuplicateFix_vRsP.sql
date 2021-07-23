SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE dbo.TagAnnotationDuplicateFix_vRsP
	@BatchSize int 	= 100

AS

/*************************  TagAnnotationDuplicateFix_vRsP  *************************

	Comments
		TagAnnotation Duplicate Fix
		
		This is a one time fix.  This is not a job process.
		
		6,721,956 row(s) affected
		
		

	History
		10.13.2014	Tad Peterson
			-- wrote
						

************************************************************************************/
SET NOCOUNT ON


DECLARE @BatchSizeCheck			int
SET	@BatchSizeCheck				= CASE WHEN @BatchSize 					> 0		THEN 1							ELSE 0		END



-- For use with RAISERROR
DECLARE @message	nvarchar(200)


-- Count Variable
DECLARE @CurrentCount		int



-- Does not process if table does not exist
IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_TagAnnotation_DupFix') AND type = (N'U'))
BEGIN
		SET @message = 'Table does not exist:  _TagAnnotation_DupFix'
		RAISERROR (@message,0,1) with NOWAIT  

		RETURN
END




-- Does not process if table does not exist
IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_TagAnnotation_DupFix_Processed') AND type = (N'U'))
BEGIN

		SET @message = 'Table does not exist:  _TagAnnotation_DupFix_Processed'
		RAISERROR (@message,0,1) with NOWAIT  

		RETURN
END



-- Sets count
SET @CurrentCount = ( SELECT COUNT(1)	FROM _TagAnnotation_DupFix )


SET @message = ''
RAISERROR (@message,0,1) with NOWAIT  

SET @message = 'Remaining records to be processed:    ' + REPLACE(CONVERT(varchar(20), (CAST( @CurrentCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  



-- Working Table
IF  @CurrentCount > 0
BEGIN

	IF OBJECT_ID('tempdb..#TagAnnotation_DupFix') IS NOT NULL			DROP TABLE #TagAnnotation_DupFix		
	CREATE TABLE #TagAnnotation_DupFix
		(
			RowId						int identity( 1, 1 )	
			, TagAnnotationObjectId		int
			
			, CONSTRAINT PK_TagAnnotation_DupFix_WorkingTable PRIMARY KEY CLUSTERED
				( RowId ASC ) WITH ( FILLFACTOR = 100 ) 
		)



	-- Process Batch
	INSERT INTO #TagAnnotation_DupFix ( TagAnnotationObjectId )
	SELECT
			TOP ( @BatchSize )
			ObjectId
	FROM
			_TagAnnotation_DupFix
	ORDER BY
			RowId



	SET @message = 'Processing BatchSize:                 ' + REPLACE(CONVERT(varchar(20), (CAST( @BatchSize  as money  )), 1), '.00', '')
	RAISERROR (@message,0,1) with NOWAIT  
			

	-- Delete TagAnnotation
	DELETE
			TagAnnotation
	WHERE
			ObjectId IN 
						(
							SELECT
									TagAnnotationObjectId
							FROM
									#TagAnnotation_DupFix
						)
									

									
	-- Updates Processing table
	INSERT INTO _TagAnnotation_DupFix_Processed ( ObjectId, CommentId, Annotation, BeginIndex, EndIndex )
	SELECT
			ObjectId
			, CommentId
			, Annotation
			, BeginIndex
			, EndIndex
	FROM
			_TagAnnotation_DupFix
	WHERE
			ObjectId IN 
						(
							SELECT
									TagAnnotationObjectId
							FROM
									#TagAnnotation_DupFix
						)



	-- Delete batch from main table
	DELETE
			_TagAnnotation_DupFix
	WHERE
			ObjectId IN 
						(
							SELECT
									TagAnnotationObjectId
							FROM
									#TagAnnotation_DupFix
						)



	-- Trancates working temp table
	TRUNCATE TABLE #TagAnnotation_DupFix		


END	
		
		
		
		
		
-- Remaining Counts
SET @CurrentCount = ( SELECT COUNT(1)	FROM _TagAnnotation_DupFix )

SET @message = ''
RAISERROR (@message,0,1) with NOWAIT  

SET @message = 'Remaining records to be processed:    ' + REPLACE(CONVERT(varchar(20), (CAST( @CurrentCount  as money  )), 1), '.00', '')
RAISERROR (@message,0,1) with NOWAIT  
	
		
		
		
		
		
		
		
		
		
		
		
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
