SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [Monitor].[Blocking_Opsview]
	(	@warning		int
		, @critical		int
	)
AS
/****************************************  OPS View Blocking  ****************************************
	
	Ops View Blocking
	
	Important to modify Proc for specific database specific to server
		-> Line regarding	y.dbid = 9

		--Locate database id
			SELECT Name, Database_Id	FROM sys.databases
			
		-- adjusted block durations from 10000 to 45000 milliseconds	

		
	Created: 3.13.2013
	
	Modified:
		3.13.2013	Tad Peterson
			- Wrote and Tested
		07.13.2016	In-Kap Bang
			- Simplifying @dTT01 population
			

*****************************************************************************************************/
DECLARE @dTT01	TABLE
	(
		rowId				int Identity(1,1)
		, hostname			varchar(max)
		, spid				int
		, blocked			int
		, status			varchar(max)
		, waitTime			int
		, program_Name		varchar(max)
		, cmd				varchar(max)
		, loginName			varchar(max)
		, cpu				bigInt
		, memUsage			bigInt
		, sqlText			nvarchar(max)
		
	)	


INSERT INTO @dTT01 ( hostname, spid, blocked, status, waitTime, program_Name, cmd, loginName, cpu, memUsage, sqlText )
SELECT
		hostname
		, spid
		, blocked
		, status
		, waitTime		--in milliseconds
		, program_Name
		, cmd
		, loginame
		, cpu
		, memUsage
		, sqlText

FROM	(
			SELECT	
					x.hostname, spid,blocked,status,waitTime,program_name,cmd,loginame,cpu,memUsage,x.dbid
					, sql.text 		AS sqltext
			FROM	
					master.dbo.sysprocesses	x
				CROSS APPLY  
					sys.dm_exec_sql_text(x.sql_handle) sql
			WHERE	
					x.blocked > 0
				AND
				 (	x.waittime > 45000
				OR   
					x.spid in ( SELECT blocked 	FROM sys.sysprocesses WHERE blocked > 0 AND waittime > 45000 )
				 )
		)	y
WHERE 
		y.dbid = 6		--activemqdb
ORDER BY 
		blocked, waitTime, cmd, spid	 ASC	



--SELECT * FROM @dTT01






DECLARE @Count		int
SET		@Count		= ( SELECT COUNT(1)		FROM @dTT01	)



--SELECT @Count


IF @Count > 0
BEGIN

	DECLARE @Blocking					int
	SET		@Blocking					=	( SELECT COUNT(1)		FROM @dTT01		WHERE RowId = 1		AND		blocked = 0		AND		waitTime = 0	) 

	DECLARE @Contention					int
	SET		@Contention					=	( SELECT COUNT(1)		FROM @dTT01		WHERE RowId = 1		AND		blocked = 0		AND		waitTime > 0	) 

	DECLARE @ContentionUnidentified		int
	SET		@ContentionUnidentified		=	( SELECT COUNT(1)		FROM @dTT01		WHERE RowId = 1		AND		blocked > 0		AND		waitTime > 0	) 

	DECLARE @HostName					varchar(10)
	SET		@HostName					= 	( SELECT HostName		FROM @dTT01		WHERE RowId = 1 )

	DECLARE @LoginName					varchar(25)
	SET		@LoginName					= 	( SELECT LoginName		FROM @dTT01		WHERE RowId = 1 )

	DECLARE @SPID						int
	SET		@SPID						= 	( SELECT SPID			FROM @dTT01		WHERE RowId = 1 )

	DECLARE @Cmd						varchar(25)
	SET		@Cmd						= 	( SELECT Cmd			FROM @dTT01		WHERE RowId = 1 )

	DECLARE @BlockedQnty				int
	SET		@BlockedQnty				= 	( @Count - 1 )


	DECLARE @SqlText					varchar(max)
	SET		@SqlText					= 	( SELECT SqlText		FROM @dTT01		WHERE RowId = 1 )

	



	--Blocking
	IF @Blocking > 0
	BEGIN
		SELECT 'Blocking; Host: ' + @HostName + ' Login: ' + @LoginName + ' SPID: ' + CAST( @SPID as varchar ) + '     Cmd: ' + @Cmd + ' BlockedQnty: ' +  CAST( @BlockedQnty as varchar ) 	+ ' | ''BlockedQnty''=' + CAST( @BlockedQnty as varchar )  as OUTPUT, 2 as StateValue
	END

	--Contention
	IF @Contention > 0
	BEGIN
		SELECT 'Contention; Should Clear Itself' as output, 1 as StateValue
	END

	--ContentionUnidentified
	IF @ContentionUnidentified > 0
	BEGIN
		SELECT 'Contention; Unidentified' as output, 1 as StateValue
	END
	 
END

--Returns OK info to Opsview
IF @Count = 0
BEGIN
	SELECT 'OK'+ ' | ''BlockedQnty''=' + CAST( '0' as varchar )  as OUTPUT, 0 as StateValue
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
