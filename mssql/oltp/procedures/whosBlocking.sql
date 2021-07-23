SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-----This is used to quickly see if there is still a blocking process

CREATE Procedure [dbo].[whosBlocking]
AS

-----Quick Look at BLOCKS

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
		, loginame			varchar(max)
		, cpu				bigInt
		, memUsage			bigInt
		, sqlText			nvarchar(max)
		
	)	


INSERT INTO @dTT01 ( hostname, spid, blocked, status, waitTime, program_Name, cmd, loginame, cpu, memUsage, sqlText )
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
					x.*
					, sql.text 		AS sqltext
			FROM	
					master.dbo.sysprocesses	x
				CROSS APPLY  
					sys.dm_exec_sql_text(x.sql_handle) sql
			WHERE	
					x.blocked > 0
				AND
					x.waittime > 10000
				OR   
					x.spid in (SELECT blocked 	FROM sys.sysprocesses WHERE blocked > 0 AND waittime > 10000)
		)	y
WHERE 
		y.dbid = 6		--activemqdb
ORDER BY 
		blocked, waitTime, cmd, spid	 ASC	

SELECT * FROM @dTT01
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
