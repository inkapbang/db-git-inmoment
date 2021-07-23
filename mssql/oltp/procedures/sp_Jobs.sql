SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[sp_Jobs]
	@jobName	varchar(255)	= ''

AS
/********************  View All Jobs In Production  *****************************

	Execute entire script all at once.
	Last line is where you can restrict what your looking for.
	


*********************************************************************************/
SET NOCOUNT ON
/*
DECLARE @dTT01 TABLE
	(
		serverName		varchar(100)
		, jobName		varchar(100)
		, enabled		bit
	)
	
INSERT INTO @dTT01
SELECT 
		'Doctor'	AS serverName
		, name		AS jobName
		, enabled

FROM 
		MSDB.DBO.SYSJOBS

UNION ALL


SELECT 
		'Bat'	AS serverName
		, name		AS jobName
		, enabled

FROM 
		bat.MSDB.DBO.SYSJOBS

UNION ALL

SELECT 
		'Chest'	AS serverName
		, name		AS jobName
		, enabled

FROM 
		CHEST.MSDB.DBO.SYSJOBS

UNION ALL

SELECT 
		'Roy'	AS serverName
		, name		AS jobName
		, enabled

FROM 
		roy.MSDB.DBO.SYSJOBS

UNION ALL

SELECT 
		'Treasure'	AS serverName
		, name		AS jobName
		, enabled

FROM 
		treasure.MSDB.DBO.SYSJOBS

		
ORDER BY serverName, jobName
	
	
	
---------------------------------
	
	
SELECT
		*
FROM
		@dTT01
WHERE
		jobName LIKE '%' + @jobName + '%'


*/


/***************************************


UPDATE treasure.MSDB.DBO.SYSJOBS
SET enabled = 0
WHERE name LIKE 'ReindexOffline'



****************************************/				
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
