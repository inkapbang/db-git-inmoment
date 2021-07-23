SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_admin_ProductionStats_vTad]
AS

/********************* Table Stats In Production OLTP  *********************

	Keeps stats on each Table in Production Environment
	
	Emails the information each morning

	usp_admin_ProductionStats_vTad

****************************************************************************/
/********************  Initial Environment Setup  **************************

--DROP TABLE ProductionStats

CREATE TABLE ProductionStats
	(
		rowId				bigInt Identity(1,1)
		, date				dateTime
		, tableName			varchar(100)
		, rowCounts			bigInt
		, total 			bigInt
		, data				bigInt
		, indexSize			bigInt
		, unUsed			bigInt
	)


CREATE CLUSTERED INDEX IX_Clus_ProductionStats_RowId
ON ProductionStats (rowId, date ASC)

CREATE 	NONCLUSTERED INDEX IX_Non_ProductionStats_Date
ON ProductionStats (date DESC)
		
CREATE UNIQUE INDEX IX_Unq_ProductionStats_date_tableName
ON ProductionStats ( date, tableName )

***************************************************************************/




DECLARE @dTT01	TABLE
	(
		rowId				bigInt Identity(1,1)
		, date				dateTime
		, tableName			varchar(100)
		, rowCounts			bigInt
		, total 			bigInt
		, data				bigInt
		, indexSize			bigInt
		, unUsed			bigInt

	)


	
	
	
INSERT INTO @dTT01 ( date, tableName, rowCounts )	
SELECT 
		CAST(FLOOR(CAST(getDate() as float))as datetime)
		, tbl.name												AS tableName
		, si.rowCnt												AS rowCounts

FROM 
		sysindexes si
	INNER JOIN 
		sys.tables tbl 
				ON si.id = tbl.object_id 
					AND indid < 2 
WHERE
		tbl.name NOT LIKE '%/_%' ESCAPE '/'
	AND
		tbl.name NOT LIKE '%[0-9]%'
	AND
		tbl.name NOT LIKE '%bak%'
	AND
		tbl.name NOT LIKE '%bob%'
	AND
		tbl.name NOT LIKE '%copy%'
	AND
		tbl.name NOT LIKE '%scrub%'
	AND
		tbl.name NOT LIKE '%tmp%'
	AND
		tbl.name NOT LIKE '%load%'
	AND
		tbl.name NOT LIKE '%test%'
	AND
		tbl.name NOT LIKE '%hertz%'
	AND
		tbl.name NOT LIKE '%ontario%'
	AND
		tbl.name NOT LIKE '%McDonalds%'
	AND	
		tbl.name NOT LIKE 'SurveyResponseTagOld'
	AND
		tbl.name NOT LIKE 'sysarticles'
	AND
		tbl.name NOT LIKE 'syssubscriptions'
	AND
		tbl.name NOT LIKE 'sysdiagrams'
	AND
		tbl.name NOT LIKE 'sysreplservers'
	AND
		tbl.name NOT LIKE 'systranschemas'
	AND
		tbl.name NOT LIKE 'syspublications'		
	AND
		tbl.name NOT LIKE 'sysarticleupdates'		
	AND
		tbl.name NOT LIKE 'sysschemaarticles'
	AND
		tbl.name NOT LIKE 'sysarticlecolumns'		
	AND
		tbl.name NOT LIKE 'dtproperties'
	AND
		tbl.name NOT LIKE 'organizationwithinbox'
	AND
		tbl.name NOT LIKE 'ProductionStats'
	AND
		tbl.name NOT LIKE 'CDC%'
	AND
		tbl.name NOT LIKE 'config'
	AND
		tbl.name LIKE '%[A-Z]'
	AND
		schema_id = 1		
		

ORDER BY  tbl.name ASC



--SELECT *	FROM @dTT01


-----Iterates Thru List
DECLARE @dTT02 TABLE
	(
		tableName			varchar(100)
		, rowCounts			bigInt
		, total				varchar(50)
		, data				varchar(50)
		, indexSize			varchar(50)
		, unUsed			varchar(50)
	)

	
DECLARE @maxRowCount		int
SET		@maxRowCount		=  ( SELECT MAX(rowId)	FROM @dTT01 )

DECLARE @curRowCount		int
SET		@curRowCount		= ( SELECT MIN(rowId)	FROM @dTT01 )

DECLARE @sqlCode	nvarchar(max)


WHILE @curRowCount <= @maxRowCount
BEGIN

SET @sqlCode = ( SELECT 'sp_spaceUsed ''' + tableName + ''''	FROM @dTT01		WHERE rowId = @curRowCount )

--SELECT @sqlCode

INSERT INTO @dTT02 ( tableName, rowCounts, total, data, indexSize, unUsed )
EXEC ( @sqlCode )

SET @curRowCount = @curRowCount + 1



END


--SELECT *	FROM @dTT02




-----Transform Data
DECLARE @dTT03 TABLE
	(
		tableName			varchar(100)
		, rowCounts			bigInt
		, total				varchar(50)
		, data				varchar(50)
		, indexSize			varchar(50)
		, unUsed			varchar(50)
	)

INSERT INTO @dTT03 ( tableName, rowCounts, total, data, indexSize, unUsed )
SELECT
		tableName
		, rowCounts
		, CAST( REPLACE( total		, 'KB', '') AS bigInt )
		, CAST( REPLACE( data		, 'KB', '') AS bigInt )
		, CAST( REPLACE( indexSize	, 'KB', '') AS bigInt )
		, CAST( REPLACE( unUsed		, 'KB', '') AS bigInt )
FROM
		@dTT02

ORDER BY rowCounts DESC


		
--SELECT *	FROM @dTT03


UPDATE t01
SET t01.total = t03.total
	, t01.data = t03.data
	, t01.indexSize = t03.indexSize
	, t01.unUsed = t03.unUsed
FROM
		@dTT01	t01
	JOIN
		@dTT03	t03
			ON t01.tableName = t03.tableName


--SELECT * FROM @dTT01


INSERT INTO ProductionStats ( date, tableName, rowCounts, total, data, indexSize, unUsed )
SELECT
		date
		, tableName
		, rowCounts
		, total
		, data
		, indexSize
		, unUsed
FROM
		@dTT01

ORDER BY rowId ASC		




--SELECT *	FROM ProductionStats
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
