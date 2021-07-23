SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		In-Kap Bang
-- Create date: 2016.09.26
-- Description:	Update Statistics Selectively
-- =============================================
CREATE PROCEDURE [dbo].[usp_maint_index_updateStatistics]
@ThresholdInMinutes INT = 720

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ThresholdDT DATETIME
	SET @ThresholdDT = DATEADD(mi,-1 * @ThresholdInMinutes,GETDATE())
	PRINT 'ThresholdDT: ' + CONVERT(VARCHAR(100),@ThresholdDT)

	DECLARE @TBLNAME VARCHAR(256), @SCHEMANAME VARCHAR(20), @LASTSTAT_DT DATETIME
	DECLARE @STATS_CMD VARCHAR(4000)

	DECLARE STATS_CUR CURSOR FOR
	SELECT	sysobj.name AS objectname,
			sysschemas.name AS schemaName,
			min(Stats_date(sysindex.[object_id], sysindex.index_id)) AS DT_StatsUpdate
	FROM	sys.objects AS sysobj WITH (nolock)
			INNER JOIN sys.schemas AS sysschemas WITH (NOLOCK) ON sysobj.[schema_id] = sysschemas.[schema_id]
			INNER JOIN sys.indexes AS sysindex WITH (NOLOCK) ON sysobj.[object_id] = sysindex.[object_id]
			INNER JOIN sys.stats AS sysstats WITH (NOLOCK) ON (sysindex.[object_id] = sysstats.[object_id] AND sysindex.index_id = sysstats.stats_id)
	WHERE	sysobj.[type] IN ( 'U', 'V' )
	GROUP BY sysobj.name,sysschemas.name
	HAVING (min(Stats_date(sysindex.[object_id], sysindex.index_id)) is null OR min(Stats_date(sysindex.[object_id], sysindex.index_id)) < @ThresholdDT)

	OPEN STATS_CUR

	FETCH NEXT FROM STATS_CUR INTO @TBLNAME, @SCHEMANAME, @LASTSTAT_DT
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SET @STATS_CMD = 'UPDATE STATISTICS ' + @SCHEMANAME + '.' + @TBLNAME + ' ;'
		EXEC(@STATS_CMD)
		--PRINT @STATS_CMD
		--PRINT 'UPDATE STATISTICS COMPLETE ON ' + @SCHEMANAME + '.' + @TBLNAME 
	
		FETCH NEXT FROM STATS_CUR INTO @TBLNAME, @SCHEMANAME, @LASTSTAT_DT
	END

	CLOSE STATS_CUR
	DEALLOCATE STATS_CUR

	RETURN 0

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
