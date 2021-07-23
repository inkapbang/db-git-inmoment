SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		In-Kap Bang
-- Create date: 2017.04.17
-- Description:	Configurable Update Statistics
-- =============================================
CREATE PROCEDURE [dbo].[Maint_UpdateStatistics] 

AS
BEGIN

	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Check for newly-added tables and add them to Maint_UpdateStatisticsSetting table
	SELECT	'[' + SCHEMA_NAME(t.schema_id) + '].[' + t.name + ']' AS fulltable_name, 
		SCHEMA_NAME(t.schema_id) AS schema_name, 
		t.name AS table_name, 
		i.rows,
		case
			when i.rows < 1000000 then 'WITH FULLSCAN'
			when i.rows >= 1000000 then '' END as parameterSetting
	INTO	#UPDSTAT_TBL
	FROM	sys.tables AS t 
			INNER JOIN sys.sysindexes AS i ON t.object_id = i.id AND i.indid < 2
	WHERE	(t.name not like '[_]%' and t.name not like 'tmp%' and t.name not like 'temp%')

	INSERT INTO Maint_UpdateStatisticsSetting (fulltable_name,schema_name,table_name,rows,parameterSetting)
	SELECT	fulltable_name,schema_name,table_name,rows,parameterSetting
	FROM	#UPDSTAT_TBL
	WHERE	fulltable_name NOT IN (select fulltable_name from Maint_UpdateStatisticsSetting with (nolock))

	UPDATE Maint_UpdateStatisticsSetting SET rows = t.rows FROM #UPDSTAT_TBL t WHERE Maint_UpdateStatisticsSetting.fulltable_name = t.fulltable_name

	DELETE FROM Maint_UpdateStatisticsSetting WHERE fulltable_name not in (select fulltable_name from #UPDSTAT_TBL)


	DROP TABLE #UPDSTAT_TBL

	--Cursor through table list and update statistics according to the parameterSetting

	DECLARE @SQL nvarchar(2000)
	DECLARE @TBL_NAME varchar(512)
	DECLARE @ParameterSetting varchar(256)
	DECLARE UPD_STAT_CUR CURSOR FOR
			SELECT	fulltable_name,
					parameterSetting
			FROM	Maint_UpdateStatisticsSetting WITH (NOLOCK)
			ORDER BY rows

	OPEN UPD_STAT_CUR
	FETCH NEXT FROM UPD_STAT_CUR INTO @TBL_NAME,@ParameterSetting
	WHILE @@FETCH_STATUS = 0
	BEGIN
		

		SET @SQL = 'UPDATE STATISTICS ' + @TBL_NAME + ' ' + @ParameterSetting + ';'
		--PRINT @SQL
		EXEC(@SQL)

		UPDATE Maint_UpdateStatisticsSetting SET dateModified = GETDATE() WHERE fulltable_name = @TBL_NAME

		FETCH NEXT FROM UPD_STAT_CUR INTO @TBL_NAME,@ParameterSetting
	END

	CLOSE UPD_STAT_CUR
	DEALLOCATE UPD_STAT_CUR

	RETURN 0
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
