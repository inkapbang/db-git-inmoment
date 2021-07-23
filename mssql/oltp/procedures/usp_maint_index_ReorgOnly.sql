SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		In-Kap Bang
-- Create date: 2016.09.26
-- Description:	Perform Index Reorganization
-- =============================================
CREATE PROCEDURE [dbo].[usp_maint_index_ReorgOnly]
@MaxDuration int = 600
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @MaxTS datetime, @FragPercent float, @IDX_CMD VARCHAR(4000)
	SET @MaxTS = DATEADD(mi,@MaxDuration,GETDATE())
	SET @FragPercent = 10
	PRINT 'Timestamp To Terminate: ' + CONVERT(VARCHAR(100),@MaxTS)
	PRINT 'Frag. Percentage Threshold: ' + CONVERT(VARCHAR(100),@FragPercent)


	DECLARE @TblName VARCHAR(256), @NumRows BIGINT, @TblId INT, @SchemaName VARCHAR(20), @IndexName VARCHAR(512), @IndexId INT, @LOB_Flag BIT

	WHILE ( @MaxTS > GETDATE())
	BEGIN
		SELECT TOP 1
				@TblId =		SO.OBJECT_ID,
				@SchemaName =	SS.name,
				@TblName =		MI.tableName,
				@LOB_Flag =		MI.LOBPresent,
				@NumRows =		MI.numRows,
				@IndexName =	MI.indexName,
				@IndexId =		MI.indexId
		FROM	dbo.Maint_IndexStatistics MI
				INNER JOIN SYS.OBJECTS SO ON MI.tableName = SO.name and SO.type = 'U'
				INNER JOIN SYS.SCHEMAS SS ON SO.schema_id = SS.schema_id
		WHERE	(MI.LOBPresent = 1 OR MI.numRows > 3000000000) 
				AND MI.completeFlag = 0
				AND (MI.avg_fragmentation_in_percent > @FragPercent OR MI.avg_fragmentation_in_percent IS NULL)
		ORDER BY NEWID(),MI.numRows, MI.indexId

		IF @@ERROR = 0 AND @@ROWCOUNT = 1
		BEGIN

			TRUNCATE TABLE dbo.Maint_IndexReorg_CurrentOp
			INSERT INTO dbo.Maint_IndexReorg_CurrentOp VALUES (@TblName,@IndexName)

			SET @IDX_CMD = 'ALTER INDEX ' + @IndexName + ' ON ' + @SchemaName + '.' + @TblName + ' REORGANIZE;'
			--PRINT @IDX_CMD
			EXEC(@IDX_CMD)

			UPDATE dbo.Maint_IndexStatistics SET completeFlag = 1 WHERE tableName = @TblName AND indexName = @IndexName AND indexId = @IndexId

		END
		ELSE GOTO IDX_REBUILD_END
	END



	IDX_REBUILD_END:
		PRINT 'NO FURTHER ROWS TO PROCESS. ENDING INDEX REBUILD PROCESS.'

	RETURN 0



END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
