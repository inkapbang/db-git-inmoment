SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE PROCEDURE Whats_Changed
CREATE PROCEDURE [dbo].[Whats_Changed]

AS



/*
****************************  Whats Changed  ****************************
	
	
	History
		12.05.2013 Tad Peterson
			-- thinking about this for a while now.

			
			
			
			
-- Reminder 
Build a whats different script.  Place into a single table with date and server 
info and category info so it can be self join to different date timeframes can be compared.  
Build a results set to printout in text format like I have seen recently ( sqlserver.com article ).
	-- Security Queries: Database-level
	http://www.sqlservercentral.com/scripts/Secure/103748/

The printout should list hardward config stuff and what has changed as the top two categories.  
Then it can go into detail on remaining items id desired.
This is an ever increasing list as more knowledge will be acquired over time and study.

 
	1.  Use Glen Berry scripts mainly hardware configs 
	2.  sys.configurations or Sp_configure settings "value_in_use" - DONE
	3.  Waits stats - still needs; see glen berry scripts
	4.  Perfmon counters
	5.  Sp_Blitz
	6.  Index usage data & configurations ( unused indexes print out )
	7.  Jobs
	8.  SQL Server Configuration
	9.	Session Info
	10. Maintenance history
	11. LogInfo	- DONE
	12. Statistics info & configurations setttings
	13. Isolation Level of Database
	14. Initialization of database files; LSPolicy -> Perform volume maintenance tasks -> add sql service account
	15. TempDb size difference; adjust configuration of tempDb accordingly to new size
	16. 
 
 


-- Document your approach
Goal
When
What data and how oftem
Scripts to capture data
Scripts to report data
			
			
			
			
			
**************************************************************************************

*/

/*  Table Setup


TRUNCATE TABLE Master..WhatsChanged


DROP TABLE Master..WhatsChanged


CREATE TABLE Master..WhatsChanged
	(
		RowId			int identity( 1,1 )
		, ServerName	varchar(25)
		, Criteria		varchar(255)
		, Description	varchar(255)
		, Timestamp		smallDateTime
		, CONSTRAINT PK_WhatsChanged PRIMARY KEY CLUSTERED
			( RowId ASC ) WITH ( FILLFACTOR = 100) 
	)
	
	
CREATE NONCLUSTERED INDEX WhatsChanged_Timestamp 
ON Master..WhatsChanged( Timestamp ) INCLUDE ( Criteria, Description ) 
WITH ( FILLFACTOR = 100 )


-- First Alternate Method of adding PK CLustered Index
ALTER TABLE Master..WhatsChanged
ADD CONSTRAINT PK_WhatsChanged PRIMARY KEY CLUSTERED
( RowId ASC )
WITH ( FILLFACTOR = 100, DROP_EXISTING = ON, ONLINE = ON )

						-- drop_existing will fail if it 
						-- does not have one already


-- Second Alternate method of PK Clustered; from Paul Randal AdvCorRecTech course
CREATE UNIQUE CLUSTERED INDEX PK_WhatsChanged 
	ON Master..WhatsChanged ( RowId )
							-- drop_exis
	WITH ( FILLFACTOR = 100, DROP_EXISTING = ON, ONLINE = ON )
	-- if using partitions
	ON [Sales4Partitions_PS] ([SalesID])
GO


*/



SET NOCOUNT ON

DECLARE @timestamp		smallDateTime
SET 	@timestamp		= getDate()


-- Visual & Testing
--SELECT @timestamp



-- Loop Variable Declares
DECLARE @CriteriaItemCount		int
DECLARE @RowId					int
DECLARE @MinRow					int
DECLARE @MaxRow					int
DECLARE @CriteriaItemName		varchar(50)





-- SQL and OS Version information for current instance  (Query 1) (Version Info)
INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
SELECT
		@@SERVERNAME
		, 'SQL Server and OS Version Info'
		, @@VERSION 	
		, @timestamp
;



-- When was SQL Server installed  (Query 2) (SQL Server Install Date)

-- Tells you the date and time that SQL Server was installed
-- It is a good idea to know how old your instance is
INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp ) 
SELECT 
		@@SERVERNAME
		, 'SQL Server Install Date'
		, createDate
		, @timestamp
FROM 
		sys.syslogins WITH (NOLOCK)
WHERE 
		[sid] = 0x010100000000000512000000;
;




-- Get selected server properties (SQL Server 2008)  (Query 3) (Server Properties)

-- This gives you a lot of useful information about your instance of SQL Server
INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp ) 
SELECT 
		@@SERVERNAME
		, 'Machine Name'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('MachineName') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		, 'Server Name'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('ServerName') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		, 'Instance Name'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('InstanceName') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		, 'Is Clustered'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('IsClustered') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		-- This is the active side of the cluster
		, 'Computer Name Physical NetBIOS'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('ComputerNamePhysicalNetBIOS') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		, 'SQL Server Edition'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('Edition') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		, 'Product Level'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('ProductLevel') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		, 'Product Version'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('ProductVersion') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		, 'Process Id'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('ProcessID') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		, 'Collation'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('Collation') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		, 'Is Full Text Installed'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('IsFullTextInstalled') )
		, @timestamp
UNION ALL
SELECT 
		@@SERVERNAME
		, 'Is Integrated Security Only'
		, CONVERT( VARCHAR(255), SERVERPROPERTY('IsIntegratedSecurityOnly') )
		, @timestamp
		

;
		
		
		

-- Windows information (SQL Server 2008 R2 SP1 or greater)  (Query 4) (Windows Info)

-- Gives you major OS version, Service Pack, Edition, and language info for the operating system
INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp ) 
SELECT
 		@@SERVERNAME
		, 'Windows Release'
		, CONVERT( VARCHAR(255), windows_release )
		, @timestamp
FROM 
		sys.dm_os_windows_info WITH (NOLOCK)
UNION ALL
SELECT
 		@@SERVERNAME
		, 'Windows Service Pack Level'
		, CONVERT( VARCHAR(255), windows_service_pack_level )
		, @timestamp
FROM 
		sys.dm_os_windows_info WITH (NOLOCK)
UNION ALL
SELECT
 		@@SERVERNAME
		, 'Windows SKU'
		, CONVERT( VARCHAR(255), windows_sku )
		, @timestamp
FROM 
		sys.dm_os_windows_info WITH (NOLOCK)
UNION ALL
SELECT
 		@@SERVERNAME
		, 'Windows OS Language Version'
		, CONVERT( VARCHAR(255), os_language_version )
		, @timestamp
FROM 
		sys.dm_os_windows_info WITH (NOLOCK) OPTION (RECOMPILE)

;


-- SQL Server Services information (SQL Server 2008 R2 SP1 or greater)  (Query 5) (SQL Server Services Info)

-- Tells you the account being used for the SQL Server Service and the SQL Agent Service
-- Shows when they were last started, and their current status
-- Shows whether you are running on a failover cluster
SET		@CriteriaItemCount	= ( SELECT COUNT(1)		FROM sys.dm_server_services WITH (NOLOCK) )

IF @CriteriaItemCount > 0
BEGIN

	IF OBJECT_ID('tempdb..##CriteriaItems_01') IS NOT NULL		DROP TABLE ##CriteriaItems_01		
	SELECT
			ROW_NUMBER() OVER(ORDER BY ServiceName ASC)		AS RowId
			, servicename
			, startup_type_desc
			, status_desc
			, last_startup_time
			, service_account
			, is_clustered
			, cluster_nodename
			
	INTO	##CriteriaItems_01
	FROM
			sys.dm_server_services WITH (NOLOCK) OPTION (RECOMPILE)
	;


	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM ##CriteriaItems_01 )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM ##CriteriaItems_01 )
	SET		@RowId	= 1



	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT servicename		FROM ##CriteriaItems_01	WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + ': Service Account Log On'
				, service_account
				, @timestamp
		FROM 
				##CriteriaItems_01
		WHERE
				RowId = @RowId	
		UNION ALL
		
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + ': Startup Type'
				, startup_type_desc
				, @timestamp
		FROM 
				##CriteriaItems_01
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + ': Status'
				, status_desc
				, @timestamp
		FROM 
				##CriteriaItems_01
		WHERE
				RowId = @RowId
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + ': Last Startup Time'
				, CONVERT( VARCHAR(255), CONVERT( smallDateTime, SUBSTRING( CONVERT( VARCHAR(255), last_startup_time ), 1, 19	 ) ) )
				--, CONVERT( VARCHAR(255), last_startup_time )
				, @timestamp
		FROM 
				##CriteriaItems_01
		WHERE
				RowId = @RowId
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + ': Is Clustered Service'
				, CONVERT( VARCHAR(255), is_clustered )
				, @timestamp
		FROM 
				##CriteriaItems_01
		WHERE
				RowId = @RowId
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + ': Active Clustered Node'
				, cluster_nodename
				, @timestamp
		FROM 
				##CriteriaItems_01
		WHERE
				RowId = @RowId
		;


		SET 	@RowId = @RowId + 1	

	END
	
	IF OBJECT_ID('tempdb..##CriteriaItems_01') IS NOT NULL		DROP TABLE ##CriteriaItems_01		
		
END		





-- Hardware information from SQL Server 2008 and 2008 R2  (Query 7) (Hardware Info)

-- NOTE ( Cannot distinguish between HT and multi-core )
-- Gives you some good basic hardware information about your database server
INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp ) 
SELECT
 		@@SERVERNAME
		, 'Physical CPU Count'
		, CONVERT( VARCHAR(255), ( cpu_count/hyperthread_ratio )  )
		, @timestamp
FROM 
		sys.dm_os_sys_info WITH (NOLOCK)
UNION ALL
SELECT
 		@@SERVERNAME
		, 'Logical CPU Count'
		, CONVERT( VARCHAR(255), ( cpu_count )  )
		, @timestamp
FROM 
		sys.dm_os_sys_info WITH (NOLOCK)
UNION ALL
SELECT
 		@@SERVERNAME
		, 'Hyperthread Ratio'
		, CONVERT( VARCHAR(255), ( hyperthread_ratio )  )
		, @timestamp
FROM 
		sys.dm_os_sys_info WITH (NOLOCK)
UNION ALL
SELECT
 		@@SERVERNAME
		, 'Physical Memory (GB)'
		, CONVERT( VARCHAR(255), ROUND( ( physical_memory_in_bytes/CAST( 1073741824  as FLOAT) ), 0 )  )
		, @timestamp
FROM 
		sys.dm_os_sys_info WITH (NOLOCK)
UNION ALL
SELECT
 		@@SERVERNAME
		, 'SQL Server Start Time'
		, CONVERT( VARCHAR(255), ( sqlserver_start_time )  )
		, @timestamp
FROM 
		sys.dm_os_sys_info WITH (NOLOCK)
UNION ALL
-- affinity_type_desc is only in 2008 R2
SELECT
 		@@SERVERNAME
		, 'Affinity Type'
		, affinity_type_desc
		, @timestamp
FROM 
		sys.dm_os_sys_info WITH (NOLOCK)
;








-- SQL Server NUMA Node information  (Query 6) (SQL Server NUMA Info)

-- Gives you some useful information about the composition 
-- and relative load on your NUMA nodes
SET		@CriteriaItemCount	= ( SELECT COUNT(1)		FROM sys.dm_os_nodes WITH (NOLOCK)		WHERE node_state_desc <> N'ONLINE DAC' )

IF @CriteriaItemCount > 0
BEGIN

	IF OBJECT_ID('tempdb..##CriteriaItems_02') IS NOT NULL		DROP TABLE ##CriteriaItems_02		
	SELECT
			ROW_NUMBER() OVER(ORDER BY node_id ASC)		AS RowId
			, node_id
			, node_state_desc
			, memory_node_id
			, online_scheduler_count
			, active_worker_count
			, avg_load_balance 
			
	INTO	##CriteriaItems_02
	FROM 
			sys.dm_os_nodes WITH (NOLOCK)		
	WHERE 
			node_state_desc <> N'ONLINE DAC'

	;


	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM ##CriteriaItems_02 )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM ##CriteriaItems_02 )
	SET		@RowId	= 1



	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT CONVERT( VARCHAR(255), node_id	)		FROM ##CriteriaItems_02	WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				,  'Numa Node ' + @CriteriaItemName + ' : Node State'
				, node_state_desc
				, @timestamp
		FROM 
				##CriteriaItems_02
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				,  'Numa Node ' + @CriteriaItemName + ' : Memory Node Id'
				, CONVERT( VARCHAR(255), memory_node_id )
				, @timestamp
		FROM 
				##CriteriaItems_02
		WHERE
				RowId = @RowId
		UNION ALL
		SELECT
				@@SERVERNAME
				,  'Numa Node ' + @CriteriaItemName + ' : Online Scheduler Count'
				, CONVERT( VARCHAR(255), online_scheduler_count )
				, @timestamp
		FROM 
				##CriteriaItems_02
		WHERE
				RowId = @RowId	
					
		UNION ALL
		SELECT
				@@SERVERNAME
				,  'Numa Node ' + @CriteriaItemName + ' : Active Worker Count'
				, CONVERT( VARCHAR(255), active_worker_count )
				, @timestamp
		FROM 
				##CriteriaItems_02
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				,  'Numa Node ' + @CriteriaItemName + ' : Average Load Balance'
				, CONVERT( VARCHAR(255), avg_load_balance )
				, @timestamp
		FROM 
				##CriteriaItems_02
		WHERE
				RowId = @RowId	
		;


		SET 	@RowId = @RowId + 1	

	END
	
	IF OBJECT_ID('tempdb..##CriteriaItems_02') IS NOT NULL		DROP TABLE ##CriteriaItems_02		
		
END		





-- Get System Manufacturer and model number from  (Query 8) (System Manufacturer)

-- SQL Server Error log. This query might take a few seconds 
-- if you have not recycled your error log recently
-- This can help you determine the capabilities
-- and capacities of your database server
IF OBJECT_ID('tempdb..##ErrorLog') IS NOT NULL		DROP TABLE ##ErrorLog		
CREATE TABLE ##ErrorLog
(
	RowId			int Identity (1,1)
	, LogDate		dateTime
	, ProcessInfo	varchar(25)
	, Text			varchar(255)
)


INSERT INTO ##ErrorLog ( LogDate, ProcessInfo, Text )
EXEC xp_readerrorlog 0,1,"Manufacturer"; 




SET		@CriteriaItemCount	= ( SELECT COUNT(1)		FROM ##ErrorLog )

IF @CriteriaItemCount > 0
BEGIN

	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM ##ErrorLog )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM ##ErrorLog )
	SET		@RowId	= 1



	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				,  'Server Manufacture & Model'
				, Text
				, @timestamp
		FROM 
				##ErrorLog
		WHERE
				RowId = @RowId
		UNION ALL
		SELECT
				@@SERVERNAME
				,  'Error Log Date'
				, CONVERT( VARCHAR(255), LogDate )
				, @timestamp
		FROM 
				##ErrorLog
		WHERE
				RowId = @RowId	
			
		SET 	@RowId = @RowId + 1	


	END
	
	IF OBJECT_ID('tempdb..##ErrorLog') IS NOT NULL		DROP TABLE ##ErrorLog		

END






-- Get processor description from Windows Registry  (Query 9) (Processor Description)

-- Gives you the model number and rated clock speed of your processor(s)
-- Your processors may be running at less that the rated clock speed due
-- to the Windows Power Plan or hardware power management
IF OBJECT_ID('tempdb..##ProcessorRegRead') IS NOT NULL		DROP TABLE ##ProcessorRegRead		
CREATE TABLE ##ProcessorRegRead
(
	RowId			int Identity (1,1)
	, Value			varchar(255)
	, Data			varchar(255)
)


INSERT INTO ##ProcessorRegRead ( Value, Data )
EXEC xp_instance_regread 
	'HKEY_LOCAL_MACHINE'
	, 'HARDWARE\DESCRIPTION\System\CentralProcessor\0'
	,'ProcessorNameString'
;



SET		@CriteriaItemCount	= ( SELECT COUNT(1)		FROM ##ProcessorRegRead )

IF @CriteriaItemCount > 0
BEGIN

	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM ##ProcessorRegRead )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM ##ProcessorRegRead )
	SET		@RowId	= 1



	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				,  'Processor Type & Speed'
				, Data
				, @timestamp
		FROM 
				##ProcessorRegRead
		WHERE
				RowId = @RowId

				
		SET 	@RowId = @RowId + 1	


	END

	IF OBJECT_ID('tempdb..##ProcessorRegRead') IS NOT NULL		DROP TABLE ##ProcessorRegRead		
	
END












-- Get the current node name from your cluster nodes  (Query 10) (Current Cluster Node)
-- (if your database server is in a cluster)

-- Knowing which node owns the cluster resources is critical
-- Especially when you are installing Windows or SQL Server updates
-- You will see no results if your instance is not clustered
SET		@CriteriaItemCount	= ( SELECT COUNT(1)		FROM sys.dm_os_cluster_nodes WITH (NOLOCK) )

IF @CriteriaItemCount > 0
BEGIN

	IF OBJECT_ID('tempdb..##CriteriaItems_03') IS NOT NULL		DROP TABLE ##CriteriaItems_03		
	SELECT
			ROW_NUMBER() OVER(ORDER BY NodeName ASC)		AS RowId
			, NodeName
						
	INTO	##CriteriaItems_03
	FROM 
			sys.dm_os_cluster_nodes WITH (NOLOCK)		

	;


	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM ##CriteriaItems_03 )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM ##CriteriaItems_03 )
	SET		@RowId	= 1



	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT CONVERT( VARCHAR(255), NodeName	)		FROM ##CriteriaItems_03		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				,  'Clustering Node 0' + CAST( @RowId  as varchar(2) ) + '  :'
				, NodeName
				, @timestamp
		FROM 
				##CriteriaItems_03
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	


	END
	
	IF OBJECT_ID('tempdb..##CriteriaItems_03') IS NOT NULL		DROP TABLE ##CriteriaItems_03		

END









-- Fixed Disk Free Space
IF OBJECT_ID('tempdb..#FixedDrive') IS NOT NULL		DROP TABLE #FixedDrive		
CREATE TABLE #FixedDrive
(
	RowId			INT Identity
	, FixedDrive	VARCHAR(3)
	, [MB Free]		INT
)


INSERT INTO #FixedDrive ( FixedDrive, [MB Free] )
EXEC master..xp_fixeddrives



SET		@CriteriaItemCount	= ( SELECT COUNT(1)		FROM #FixedDrive )

IF @CriteriaItemCount > 0
BEGIN		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, 'Fixed Drive Free Space (GB)   ' + FixedDrive + ' :'
				, CAST( [MB Free] / 1024.0		AS DECIMAL( 8, 2 )  )		AS [GB Free]
				, @timestamp
		FROM 
				#FixedDrive
		ORDER BY 
				RowId


END
IF OBJECT_ID('tempdb..#FixedDrive') IS NOT NULL		DROP TABLE #FixedDrive		













-- Server wide system configuration
IF OBJECT_ID('tempdb..#SysConfigInfo') IS NOT NULL			DROP TABLE #SysConfigInfo		 
CREATE TABLE #SysconfigInfo 
(
	RowId				int Identity
	, Name				varchar(255)
	, Value_In_Use		Sql_variant
)
;

INSERT INTO #SysConfigInfo ( Name, Value_In_Use )
SELECT 
		Name
		, Value_In_Use
FROM 
		sys.configurations
;



SET		@CriteriaItemCount	= 
								( 
									SELECT
											COUNT(1)
									FROM
											#SysConfigInfo
								 )

IF @CriteriaItemCount > 0
BEGIN

	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM #SysConfigInfo )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM #SysConfigInfo )
	SET		@RowId	= 1


	
	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT Name	FROM #SysConfigInfo		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, 'Sysconfig Settings:   ' + @CriteriaItemName
				, CONVERT( VARCHAR(255), Value_In_Use	)
				--, Value_In_Use
				, @timestamp
		FROM 
				#SysConfigInfo
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	

	END


END	
IF OBJECT_ID('tempdb..#SysConfigInfo') IS NOT NULL			DROP TABLE #SysConfigInfo		 
	







	
	
	




-- Enterprise Only Fetures; Database Level
IF OBJECT_ID('tempdb..#EnterpriseFeatures') IS NOT NULL			DROP TABLE #EnterpriseFeatures		 
CREATE TABLE #EnterpriseFeatures 
(
	RowId			int Identity
	, DatabaseName	varchar(25)
	, feature_name	varchar(25)
)
;


EXEC sp_MSforeachdb N'Use [?]; 

				INSERT INTO #EnterpriseFeatures
				EXEC sp_executesql N''SELECT DB_NAME(), Feature_Name FROM sys.dm_db_persisted_sku_features''; 
	 			'



SET		@CriteriaItemCount	= 
								( 
									SELECT
											COUNT(1)
									FROM
											#EnterpriseFeatures
								 )

IF @CriteriaItemCount > 0
BEGIN

	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM #EnterpriseFeatures )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM #EnterpriseFeatures )
	SET		@RowId	= 1


	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT DatabaseName		FROM #EnterpriseFeatures		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, 'Enterprise Level Features In Use :   ' + @CriteriaItemName
				--, CONVERT( VARCHAR(255), feature_name	)
				, feature_name
				, @timestamp
		FROM 
				#EnterpriseFeatures
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	

	END

END	
IF OBJECT_ID('tempdb..#EnterpriseFeatures') IS NOT NULL			DROP TABLE #EnterpriseFeatures		 
	
	
	
	
	

	
	







--  Get logins that are connected and how many sessions they have  (Query 24) (Connection Counts)
-- This can help characterize your workload and
-- determine whether you are seeing a normal level of activity
IF OBJECT_ID('tempdb..#LoginSessionTotals') IS NOT NULL			DROP TABLE #LoginSessionTotals		 
CREATE TABLE #LoginSessionTotals 
(
	RowId				int Identity
	, Login_Name		varchar(25)
	, Session_Count		varchar(25)
)
;

INSERT INTO #LoginSessionTotals ( Login_Name, Session_Count )
SELECT 
		login_name
		, COUNT(session_id)			AS [session_count] 
FROM 
		sys.dm_exec_sessions WITH (NOLOCK)
WHERE 
		session_id > 50	-- filter out system SPIDs
GROUP BY 
		login_name
ORDER BY 
		COUNT(session_id) DESC OPTION (RECOMPILE);


;



SET		@CriteriaItemCount	= 
								( 
									SELECT
											COUNT(1)
									FROM
											#LoginSessionTotals
								 )

IF @CriteriaItemCount > 0
BEGIN

	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM #LoginSessionTotals )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM #LoginSessionTotals )
	SET		@RowId	= 1


	
	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT Login_Name	FROM #LoginSessionTotals		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, 'Login & Session Counts:   ' + @CriteriaItemName
				, CONVERT( VARCHAR(255), [Session_Count]	)
				--, [Session_Count]
				, @timestamp
		FROM 
				#LoginSessionTotals
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	

	END


END	
IF OBJECT_ID('tempdb..#LoginSessionTotals') IS NOT NULL			DROP TABLE #LoginSessionTotals		 
	





	
	







-- Get total buffer usage by database for current instance  (Query 21) (Total Buffer Usage by Database)
-- This make take some time to run on a busy instance
-- Tells you how much memory (in the buffer pool) 
-- is being used by each database on the instance
IF OBJECT_ID('tempdb..#CacheUsage') IS NOT NULL			DROP TABLE #CacheUsage		 
CREATE TABLE #CacheUsage 
(
	RowId					int Identity
	, [Database Name]		varchar(25)
	, [Cached Size (GB)]	varchar(25)
)
;

INSERT INTO #CacheUsage ( [Database Name], [Cached Size (GB)] )
SELECT 
		TOP 5
		DB_NAME(database_id)									AS [Database Name]
		, CAST(COUNT(1) * 8/1024.0/1024.0 AS DECIMAL (10,2))  	AS [Cached Size (GB)]

FROM 
		sys.dm_os_buffer_descriptors WITH (NOLOCK)
WHERE 
		database_id > 4 -- system databases
	AND 
		database_id <> 32767 -- ResourceDB
GROUP BY 
		DB_NAME(database_id)
ORDER BY 
		[Cached Size (GB)] DESC OPTION (RECOMPILE);
;



SET		@CriteriaItemCount	= 
								( 
									SELECT
											COUNT(1)
									FROM
											#CacheUsage
								 )

IF @CriteriaItemCount > 0
BEGIN

	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM #CacheUsage )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM #CacheUsage )
	SET		@RowId	= 1


	
	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT [Database Name]	FROM #CacheUsage		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, 'Cache Usage (GB) :   ' + @CriteriaItemName
				, CONVERT( VARCHAR(255), [Cached Size (GB)]	)
				--, [Cached Size (GB)]
				, @timestamp
		FROM 
				#CacheUsage
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	

	END


END	
IF OBJECT_ID('tempdb..#CacheUsage') IS NOT NULL			DROP TABLE #CacheUsage		 
	



	








-- Recovery model, log reuse wait description, log file size, log usage size  (Query 15) (Database Properties)
-- and compatibility level for all databases on instance

-- Things to look at:
-- How many databases are on the instance?
-- What recovery models are they using?
-- What is the log reuse wait description?
-- How full are the transaction logs ?
-- What compatibility level are they on?
-- What is the Page Verify Option?
-- Make sure auto_shrink and auto_close are not enabled!

SET		@CriteriaItemCount	= 
								( 
									SELECT
											COUNT(1)
	
									FROM 
											sys.databases						AS db WITH (NOLOCK)
										INNER JOIN 
											sys.dm_os_performance_counters		AS lu WITH (NOLOCK)
												ON db.name = lu.instance_name
										INNER JOIN 
											sys.dm_os_performance_counters		AS ls WITH (NOLOCK) 
												ON db.name = ls.instance_name
									WHERE 
											lu.counter_name LIKE N'Log File(s) Used Size (KB)%' 
										AND 
											ls.counter_name LIKE N'Log File(s) Size (KB)%'
										AND 
											ls.cntr_value > 0 
										AND
											(
													db.[name] LIKE 'mindshare%'
												OR
													db.[name] LIKE 'warehouse%'
												OR
													db.[name] LIKE 'tempdb'
											)	
								 )

IF @CriteriaItemCount > 0
BEGIN

	IF OBJECT_ID('tempdb..##CriteriaItems_05') IS NOT NULL		DROP TABLE ##CriteriaItems_05		
	SELECT
			ROW_NUMBER() OVER(ORDER BY db.[name] ASC)				AS RowId
			, db.[name]												AS [Database Name]
			, db.recovery_model_desc								AS [Recovery Model]
			, db.log_reuse_wait_desc								AS [Log Reuse Wait Description]
			, CAST( ls.cntr_value / 1024.0	as DECIMAL( 8, 2 )  )	AS [Log Size (MB)]
			, CAST( lu.cntr_value / 1024.0	as DECIMAL( 8, 2 )  )	AS [Log Used (MB)]
			, CAST(CAST(lu.cntr_value  as float ) / CAST(ls.cntr_value AS FLOAT)AS DECIMAL(18,2)) * 100		AS [Log Used %]
			, db.[compatibility_level]								AS [DB Compatibility Level]
			, db.page_verify_option_desc							AS [Page Verify Option]
			, db.is_auto_create_stats_on, db.is_auto_update_stats_on
			, db.is_auto_update_stats_async_on
			, db.is_parameterization_forced
			, db.snapshot_isolation_state_desc
			, db.is_read_committed_snapshot_on
			, db.is_auto_close_on
			, db.is_auto_shrink_on
			, db.is_cdc_enabled
			
	INTO	##CriteriaItems_05
	FROM 
			sys.databases						AS db WITH (NOLOCK)
		INNER JOIN 
			sys.dm_os_performance_counters		AS lu WITH (NOLOCK)
				ON db.name = lu.instance_name
		INNER JOIN 
			sys.dm_os_performance_counters		AS ls WITH (NOLOCK) 
				ON db.name = ls.instance_name
	WHERE 
			lu.counter_name LIKE N'Log File(s) Used Size (KB)%' 
		AND 
			ls.counter_name LIKE N'Log File(s) Size (KB)%'
		AND 
			ls.cntr_value > 0 
		AND
			(
					db.[name] LIKE 'mindshare%'
				OR
					db.[name] LIKE 'warehouse%'
				OR
					db.[name] LIKE 'tempdb'
			)	
;


	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM ##CriteriaItems_05 )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM ##CriteriaItems_05 )
	SET		@RowId	= 1



	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT [Database Name]		FROM ##CriteriaItems_05		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Recovery Model :'
				--, CONVERT( VARCHAR(255), [Recovery Model]	)
				, [Recovery Model]
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Log Reuse Wait :'
				--, CONVERT( VARCHAR(255), [Log Reuse Wait Description]	)
				, [Log Reuse Wait Description]
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Log Size (MB) :'
				, CONVERT( VARCHAR(255), [Log Size (MB)]	)
				--, [Log Size (KB)]
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Log Used (MB) :'
				, CONVERT( VARCHAR(255), [Log Used (MB)]	)
				--, [Log Used (KB)]
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Log Used % :'
				, CONVERT( VARCHAR(255), [Log Used %]	)
				--, [Log Used %]
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     DB Compatibility Level :'
				, CONVERT( VARCHAR(255), [DB Compatibility Level]	)
				--, [DB Compatibility Level]
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Page Verify Option :'
				--, CONVERT( VARCHAR(255), [Page Verify Option]	)
				, [Page Verify Option]
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Auto Create Stats On :'
				, CONVERT( VARCHAR(255), is_auto_create_stats_on	)
				--, is_auto_create_stats_on
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Auto Update Stats On :'
				, CONVERT( VARCHAR(255), is_auto_update_stats_on )
				--, is_auto_update_stats_on
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Auto Update Stats Async On :'
				, CONVERT( VARCHAR(255), is_auto_update_stats_async_on	)
				--, is_auto_update_stats_async_on
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Is Parameterization Forced :'
				, CONVERT( VARCHAR(255), is_parameterization_forced	)
				--, is_parameterization_forced
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Snapshot Isolation State :'
				--, CONVERT( VARCHAR(255), snapshot_isolation_state_desc	)
				, snapshot_isolation_state_desc
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Read Committed Snapshot On :'
				, CONVERT( VARCHAR(255), is_read_committed_snapshot_on	)
				--, is_read_committed_snapshot_on
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Auto Close On :'
				, CONVERT( VARCHAR(255), is_auto_close_on	)
				--, is_auto_close_on
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     Auto Shrink On :'
				, CONVERT( VARCHAR(255), is_auto_shrink_on )
				--, is_auto_shrink_on
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     CDC Enabled :'
				, CONVERT( VARCHAR(255), is_cdc_enabled )
				--, is_cdc_enabled
				, @timestamp
		FROM 
				##CriteriaItems_05
		WHERE
				RowId = @RowId	
		

		SET 	@RowId = @RowId + 1	


	END

	IF OBJECT_ID('tempdb..##CriteriaItems_05') IS NOT NULL		DROP TABLE ##CriteriaItems_05		
	
END














-- Get VLF Counts for all databases on the instance (Query 17) (VLF Counts)
-- (adapted from Michelle Ufford)


IF OBJECT_ID('tempdb..#VLFInfo') IS NOT NULL			DROP TABLE #VLFInfo		 
CREATE TABLE #VLFInfo 
(
	FileID			int
	, FileSize		bigint
	, StartOffset	bigint
	, FSeqNo		bigint
	, [Status]		bigint 
	, Parity		bigint
	, CreateLSN		numeric(38)
)
;


IF OBJECT_ID('tempdb..#VLFCountResults') IS NOT NULL	DROP TABLE #VLFCountResults		 
CREATE TABLE #VLFCountResults
(
    RowId           int Identity
	, DatabaseName	sysname
	, VLFCount		int
	, VLFAvgSizeMB	int
)
;

	 
EXEC sp_MSforeachdb N'Use [?]; 

				INSERT INTO #VLFInfo
				EXEC sp_executesql N''DBCC LOGINFO([?])''; 
	 
				INSERT INTO #VLFCountResults ( DatabaseName, VLFCount, VLFAvgSizeMB )
				SELECT 
						DB_NAME()
						, COUNT(1)
						, AVG( FileSize )

				FROM #VLFInfo; 

				TRUNCATE TABLE #VLFInfo;'






		
SET		@CriteriaItemCount	= ( SELECT COUNT(1)		FROM #VLFCountResults )

IF @CriteriaItemCount > 0
BEGIN

	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM #VLFCountResults )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM #VLFCountResults )
	SET		@RowId	= 1



	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT DatabaseName		FROM #VLFCountResults		WHERE RowId = @RowId )


		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     VLF Count :'
				, CONVERT( VARCHAR(255), [VLFCount]	)
				--, [VLFCount]
				, @timestamp
		FROM 
				#VLFCountResults
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, @CriteriaItemName + '     VLF Avg File Size (MB) :'
				, CONVERT( VARCHAR(255), CAST( VLFAvgSizeMB / 1024.0 / 1024.0	AS DECIMAL( 8, 2 ) )	)
				--, CAST( VLFAvgSizeMB / 1024.0 / 1024.0	AS DECIMAL( 8, 2 ) )
				, @timestamp
		FROM 
				#VLFCountResults
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	


	END

	IF OBJECT_ID('tempdb..#VLFInfo') IS NOT NULL			DROP TABLE #VLFInfo		 
	
END














-- Get CPU utilization by database (adapted from Robert Pearl)  (Query 19) (CPU Usage by Database)
-- Helps determine which database is using the most CPU resources on the instance
IF OBJECT_ID('tempdb..#DB_CPU_Stats') IS NOT NULL			DROP TABLE #DB_CPU_Stats		
CREATE TABLE #DB_CPU_Stats
(
	RowId			INT Identity
	, DatabaseName	VARCHAR(25)
	, CPU_Time_Ms	BIGINT
	, CPU_Percent	DECIMAL( 8, 2 )
)

;
WITH DB_CPU_Stats
AS
(
	SELECT 
			DatabaseID
			, DB_Name(DatabaseID)				AS [DatabaseName]
			, SUM(total_worker_time)			AS [CPU_Time_Ms]
	FROM 
			sys.dm_exec_query_stats		AS qs
		CROSS APPLY 
			(
				SELECT 
						CONVERT(int, value)		AS [DatabaseID] 
				FROM 
						sys.dm_exec_plan_attributes(qs.plan_handle)
				WHERE 
						attribute = N'dbid'
			)							AS F_DB
				GROUP BY 
						DatabaseID
)
INSERT INTO #DB_CPU_Stats ( DatabaseName, CPU_Time_Ms, CPU_Percent )
SELECT 
		TOP 5
		DatabaseName
		, [CPU_Time_Ms]
		, CAST( [CPU_Time_Ms] * 1.0 / SUM( [CPU_Time_Ms] ) OVER() * 100.0 AS DECIMAL(5, 2) )	AS [CPUPercent]
FROM 
		DB_CPU_Stats
WHERE 
		DatabaseID > 4			-- system databases
	AND 
		DatabaseID <> 32767		-- ResourceDB
ORDER BY 
		[CPUPercent] DESC
;



SET		@CriteriaItemCount	= ( SELECT COUNT(1)		FROM #DB_CPU_Stats )

IF @CriteriaItemCount > 0
BEGIN

	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM #DB_CPU_Stats )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM #DB_CPU_Stats )
	SET		@RowId	= 1


	-- 1 of 2 Columns
	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT [DatabaseName]		FROM #DB_CPU_Stats		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, 'CPU Time Ms :   ' + @CriteriaItemName
				, CONVERT( VARCHAR(255), [CPU_Time_Ms]	)
				--, [CPU_Time_Ms]
				, @timestamp
		FROM 
				#DB_CPU_Stats
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	

	END



	-- 2 0f 2 Colums
	SET		@RowId	= 1
	
	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT [DatabaseName]		FROM #DB_CPU_Stats		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, 'CPU Percent :   ' + @CriteriaItemName
				, CONVERT( VARCHAR(255), [CPU_Percent]	)
				--, [CPU_Percent]
				, @timestamp
		FROM 
				#DB_CPU_Stats
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	

	END

	IF OBJECT_ID('tempdb..#DB_CPU_Stats') IS NOT NULL			DROP TABLE #DB_CPU_Stats		

END












-- Get I/O utilization by database (Query 20) (IO Usage By Database)
-- Helps determine which database is using the most I/O resources on the instance
IF OBJECT_ID('tempdb..#DB_IO_Utilization') IS NOT NULL			DROP TABLE #DB_IO_Utilization		
CREATE TABLE #DB_IO_Utilization
(
	RowId				INT Identity
	, [Database Name]	VARCHAR(25)
	, [Total I/O (GB)]	DECIMAL( 10, 2 )
	, [I/O Percent]		DECIMAL( 8, 2 )
)

;
WITH Aggregate_IO_Statistics
AS
(
	SELECT 
			DB_NAME(database_id)						AS [Database Name]
			, CAST( SUM( num_of_bytes_read + num_of_bytes_written )/1048576 AS DECIMAL( 12, 2 ) )		AS io_in_mb
	FROM 
			sys.dm_io_virtual_file_stats(NULL, NULL)	AS [DM_IO_STATS]
	GROUP BY 
			database_id
)
INSERT INTO #DB_IO_Utilization ( [Database Name], [Total I/O (GB)], [I/O Percent] )
SELECT 
		TOP 5
		--ROW_NUMBER() OVER(ORDER BY io_in_mb DESC)						AS [I/O Rank]
		[Database Name]
		, io_in_mb / 1024.0												AS [Total I/O (GB)]
		, CAST(io_in_mb/ SUM(io_in_mb) OVER() * 100.0 AS DECIMAL(5,2))	AS [I/O Percent]
FROM 
		Aggregate_IO_Statistics
ORDER BY 
		[I/O Percent] DESC
;



SET		@CriteriaItemCount	= ( SELECT COUNT(1)		FROM #DB_IO_Utilization )

IF @CriteriaItemCount > 0
BEGIN

	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM #DB_IO_Utilization )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM #DB_IO_Utilization )
	SET		@RowId	= 1


	-- 1 of 2 Columns
	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT [Database Name]		FROM #DB_IO_Utilization		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, 'Total I/O (GB) :   ' + @CriteriaItemName
				, CONVERT( VARCHAR(255), [Total I/O (GB)]	)
				--, [Total I/O (GB)]
				, @timestamp
		FROM 
				#DB_IO_Utilization
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	

	END



	-- 2 0f 2 Colums
	SET		@RowId	= 1
	
	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT [Database Name]		FROM #DB_IO_Utilization		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, 'I/O Percent :   ' + @CriteriaItemName
				, CONVERT( VARCHAR(255), [I/O Percent]	)
				--, [I/O Percent]
				, @timestamp
		FROM 
				#DB_IO_Utilization
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	

	END

	IF OBJECT_ID('tempdb..#DB_IO_Utilization') IS NOT NULL			DROP TABLE #DB_IO_Utilization		

END














-- Get information on location, time and size of any memory dumps from SQL Server (SQL Server 2008 R2 SP1 or greater)  (Query 12) (Memory Dump Info)

-- This will not return any rows if you have 
-- not had any memory dumps (which is a good thing)
SET		@CriteriaItemCount	= ( SELECT COUNT(1)		FROM sys.dm_server_memory_dumps WITH (NOLOCK) )

IF @CriteriaItemCount > 0
BEGIN
	
	-- Extra Step to output directory path
	INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
	SELECT
			DISTINCT
			@@SERVERNAME
			, 'Memory Dump Path'
			, SUBSTRING( [filename], 1, LEN([filename]) - 16 )
			, @timestamp
	FROM 
			sys.dm_server_memory_dumps WITH (NOLOCK)
	-- Extra Step to output directory path
			


	IF OBJECT_ID('tempdb..##CriteriaItems_04') IS NOT NULL		DROP TABLE ##CriteriaItems_04		
	SELECT
			ROW_NUMBER() OVER(ORDER BY [filename] ASC)		AS RowId
			, [filename]
			, creation_time
			, size_in_bytes
			
	INTO	##CriteriaItems_04
	FROM 
			sys.dm_server_memory_dumps WITH (NOLOCK) 
			;


	SET 	@MinRow	= ( SELECT MIN(rowId)	FROM ##CriteriaItems_04 )
	SET 	@MaxRow	= ( SELECT MAX(rowId)	FROM ##CriteriaItems_04 )
	SET		@RowId	= 1



	WHILE 	@RowId 	<= 	@MaxRow
	BEGIN

		SET @CriteriaItemName = ( SELECT SUBSTRING( [filename], LEN([filename]) - 15, LEN([filename]) )		FROM ##CriteriaItems_04		WHERE RowId = @RowId )
		
		INSERT INTO Master..WhatsChanged ( ServerName, Criteria, Description, Timestamp )
		SELECT
				@@SERVERNAME
				, 'Dump Date:   ' + @CriteriaItemName 
				-- left this fine grained
				, CONVERT( VARCHAR(255), creation_time	)
				, @timestamp
		FROM 
				##CriteriaItems_04
		WHERE
				RowId = @RowId	
		UNION ALL
		SELECT
				@@SERVERNAME
				, 'Dump  Size:   ' + @CriteriaItemName
				, CONVERT( VARCHAR(255), CONVERT( DECIMAL(8, 3), ( size_in_bytes / 1024.0 / 1024.0 )  )  )  + ' MB'
				, @timestamp
		FROM 
				##CriteriaItems_04
		WHERE
				RowId = @RowId	


		SET 	@RowId = @RowId + 1	


	END

	IF OBJECT_ID('tempdb..##CriteriaItems_04') IS NOT NULL		DROP TABLE ##CriteriaItems_04		

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
