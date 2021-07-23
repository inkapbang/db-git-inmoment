SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_CheckDeadlocks_vTad_old_NOTUSED]
AS

DECLARE	@blockValue		int

SET		@blockValue		=	( SELECT 
										count(1)		
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
										y.dbid !=9	--activemqdb
							)





IF 	@blockValue	>	0
BEGIN


	DECLARE @xml NVARCHAR(MAX)
	DECLARE @body NVARCHAR(MAX)


	SET @xml = CAST(( 


	SELECT
			hostname			AS 'td','',
			spid				AS 'td','',
			blocked				AS 'td','',
			status				AS 'td','',
			waittime			AS 'td','',
			program_name		AS 'td','',
			cmd					AS 'td','',
			loginame			AS 'td','',
			sqlText				AS 'td'

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
			y.dbid !=9		--activemqdb
	ORDER BY 
			blocked DESC			


			
	FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


	SET @body =
	'<html><body><H3>
	Blocked Processes	
						</H3><table border = 1><tr><th> 
	hostname			</th><th>
	spid				</th><th>
	blocked				</th><th>
	status				</th><th>
	waitTime			</th><th>
	program_Name		</th><th>
	cmd					</th><th>
	loginame			</th><th>
	sqlText				</th></tr>
	'    

	 
	SET @body = @body + @xml +'</table></body></html>'

	
	--
	DECLARE @blockName		varchar(max)
	DECLARE @bodyAction		varchar(max)
	DECLARE	@bodyExplain	varchar(max)

	SET		@blockName	=	( SELECT 
										hostName	
								FROM	
									(
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
										y.dbid !=9	--activemqdb
									AND y.waitTime = 0	
							)
 
	SET		@bodyAction		=	'Host Blocking = '+ @blockName
	SET		@bodyExplain 	=	'Check Email for More Details' 

	--

	EXEC msdb.dbo.sp_send_dbmail
	@profile_name = 'Monitor' -- replace with your SQL Database Mail Profile 
	, @body = @body
	, @body_format ='HTML'
	, @recipients = 'developers@mshare.net; mshare@mailman.xmission.com' -- Developers Email; Developers Cell
	, @subject = @bodyAction ;
			



	--Sends text regarding details of issue
	--
	
	--
	EXEC msdb.dbo.sp_send_dbmail
	@profile_name = 'Monitor'								-- replace with your SQL Database Mail Profile 
	, @body = @bodyExplain
	, @recipients = '; 8016786926@vtext.com' 	-- Tad; Bob
	, @subject = @bodyAction 								--'Monitor' 








			
			
END		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
