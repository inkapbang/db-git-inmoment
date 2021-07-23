SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_Blocks_v2Tad]
AS
/*********************************  usp_admin_Blocks_v2Tad  *********************************

	Executes on Doctor
	Job Name:	BlockedProcessNotification2Min_vTad


	Modified
		3.6.2013	Tad Peterson
			Bob requested contention text messages be turned on
		
		3.13.2013	Tad Peterson
			Moved to Opsview, removed everyone but dba from this notification




********************************************************************************************/
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
					x.waittime > 45000
				OR   
					x.spid in (SELECT blocked 	FROM sys.sysprocesses WHERE blocked > 0 AND waittime > 45000)
		)	y
WHERE 
		y.dbid = 6		--activemqdb
ORDER BY 
		blocked, waitTime, cmd, spid	 ASC	




DECLARE	@tableValue		int
SET		@tableValue		=	( SELECT COUNT(1)	FROM @dTT01 )


IF @tableValue > 0
BEGIN
	
	DECLARE @blockedValue	int
	DECLARE @waitTimeValue	int
	SET 	@blockedValue 	= ( SELECT blocked		FROM @dTT01		WHERE rowId = 1)
	SET 	@waitTimeValue 	= ( SELECT waitTime		FROM @dTT01		WHERE rowId = 1)



--Blocking	
	IF ( @blockedValue = 0 AND @waitTimeValue = 0 )
	BEGIN
		DECLARE @xml01 		NVARCHAR(MAX)
		DECLARE @body01 	NVARCHAR(MAX)


		SET @xml01 = CAST(( 


		SELECT
				hostName			AS 'td','',
				spid				AS 'td','',
				blocked				AS 'td','',
				status				AS 'td','',
				waitTime			AS 'td','',
				program_Name		AS 'td','',
				cmd					AS 'td','',
				loginame			AS 'td','',
				cpu					AS 'td','',
				memUsage			AS 'td','',
				sqlText				AS 'td'
		FROM 
				@dTT01
				
		ORDER BY blocked, waitTime, cmd, spid	 ASC	

		
		

		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


		SET @body01 =
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
		cpu					</th><th>
		memUsage			</th><th>
		sqlText				</th></tr>
		'    

		 
		SET @body01 = @body01 + @xml01 +'</table></body></html>'

		
		--
		DECLARE @blockName01			varchar(10)
		DECLARE @bodyActionEmail01		varchar(max)
		DECLARE @bodyActionText01		varchar(max)
		DECLARE @spid01					varchar(max)
		DECLARE @waitTimeMax01			varchar(max)
		DECLARE	@bodyExplain01			varchar(max)

		SET		@blockName01		= ( SELECT hostName							FROM @dTT01		WHERE rowId = 1 )
		SET		@spid01				= ( SELECT spid								FROM @dTT01		WHERE rowId = 1 )
		SET		@waitTimeMax01		= ( SELECT cast(max(waitTime)/1000 as int)	FROM @dTT01 )
		SET		@bodyActionEmail01	=	'Blocking = '+ @blockName01 + ' spid = '+ @spid01 + ' WaitTime = ' + @waitTimeMax01 + ' sec'
		SET		@bodyActionText01	=	'Blocking = '+ @blockName01
		SET		@bodyExplain01		=	'spid = '+ @spid01 + ' WaitTime = ' + @waitTimeMax01 + ' sec'
		
		--Sends email regarding details of issue
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Monitor' -- replace with your SQL Database Mail Profile 
		, @body = @body01
		, @body_format ='HTML'
		--, @recipients = 'tpeterson@mshare.net; bluther@mshare.net; kmciff@mshare.net' -- Tad; Bob
		, @recipients =	'dba@mshare.net' --; developers@mshare.net; bluther@mshare.net; kmciff@mshare.net' 	-- Developers Email; Developers Cell
		, @copy_recipients 				= 'tpeterson@mshare.net'
		, @subject = @bodyActionEmail01 ;
				



		--Sends text regarding details of issue
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Monitor'								-- replace with your SQL Database Mail Profile 
		, @body = @bodyExplain01
		, @recipients = '; 8016786926@vtext.com; ' 	-- Tad; Bob; Keith
		--, @recipients = '; 8016786926@vtext.com; 8017066481@tmomail.com; 8018287756@vtext.com; 8016784028@vmobl.com; 8016715144@vtext.com; 8014722353@vtext.com; 8014503052@VTEXT.COM; 8013620541@txt.att.net; 8015927788@vtext.com; 8018000200@tmomail.net; 8013723836@vtext.com; 8018034925@vtext.com; 8018153497@tmomail.net; 4153083267@vtext.com; 7349044463@vtext.com; 8014198393@vtext.com; 8017926463@messaging.sprintpcs.com'	--Tad, Bob, Keith, BJ, Mike, Robert, Dave, Craig, Dale, Thayn, Gavin, Wi, Scott, Matt J, Weston, Mathew, Ervin, Nate, Joel 
		, @subject = @bodyActionText01 								--'Monitor' 

	END





--Contention, Should Clear Itself
	IF ( @blockedValue = 0 AND @waitTimeValue > 0 )
	BEGIN
		DECLARE @xml02 NVARCHAR(MAX)
		DECLARE @body02 NVARCHAR(MAX)


		SET @xml02 = CAST(( 


		SELECT
				hostName			AS 'td','',
				spid				AS 'td','',
				blocked				AS 'td','',
				status				AS 'td','',
				waitTime			AS 'td','',
				program_Name		AS 'td','',
				cmd					AS 'td','',
				loginame			AS 'td','',
				cpu					AS 'td','',
				memUsage			AS 'td','',
				sqlText				AS 'td'
		FROM 
				@dTT01
		
		ORDER BY blocked, waitTime, cmd, spid	 ASC	


		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


		SET @body02 =
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
		cpu					</th><th>
		memUsage			</th><th>
		sqlText				</th></tr>
		'    

		 
		SET @body02 = @body02 + @xml02 +'</table></body></html>'

		
		--
		DECLARE @blockName02			varchar(max)
		DECLARE @bodyActionEmail02		varchar(max)
		DECLARE @bodyActionText02		varchar(max)
		DECLARE @spid02					varchar(max)
		DECLARE @waitTime02				varchar(max)
		DECLARE	@bodyExplain02			varchar(max)
		DECLARE @bodyActionEmail02Min		varchar(max)
		DECLARE @bodyActionEmail02Max		varchar(max)
		
		SET		@blockName02			= ( SELECT hostName							FROM @dTT01		WHERE rowId = 1 )
		SET		@spid02					= ( SELECT spid								FROM @dTT01		WHERE rowId = 1 )
		SET		@waitTime02				= ( SELECT cast(waitTime/1000 as int)		FROM @dTT01		WHERE rowId = 1 )
		SET 	@bodyActionEmail02Min	= ( SELECT cast(min(waitTime)/1000 as int)	FROM @dTT01 )
		SET 	@bodyActionEmail02Max	= ( SELECT cast(max(waitTime)/1000 as int)	FROM @dTT01 )		
		SET		@bodyActionEmail02		=	'Contention, Should Clear Itself; WaitTimes ' + @bodyActionEmail02Min + ' - ' + @bodyActionEmail02Max + ' sec'
		SET		@bodyActionText02		=	'Contention = '+ @blockName02
		SET		@bodyExplain02 			=	'spid = '+ @spid02
		
		--Sends email regarding details of issue
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Monitor' -- replace with your SQL Database Mail Profile 
		, @body = @body02
		, @body_format ='HTML'
		--, @recipients = 'tpeterson@mshare.net; bluther@mshare.net; kmciff@mshare.net' -- Tad; Bob; Keith
		, @recipients =	'dba@mshare.net' --; developers@mshare.net; bluther@mshare.net; kmciff@mshare.net' 	-- Developers Email; Developers Cell
		, @copy_recipients = 'tpeterson@mshare.net'

		, @subject = @bodyActionEmail02 ;





		--Sends text regarding details of issue
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Monitor'								-- replace with your SQL Database Mail Profile 
		, @body = @bodyExplain02
		, @recipients = '; 8016786926@vtext.com; ' 	-- Tad; Bob; Keith
		--, @recipients = '; 8016786926@vtext.com; 8017066481@tmomail.com; 8018287756@vtext.com; 8016784028@vmobl.com; 8016715144@vtext.com; 8014722353@vtext.com; 8014503052@VTEXT.COM; 8013620541@txt.att.net; 8015927788@vtext.com; 8018000200@tmomail.net; 8013723836@vtext.com; 8018034925@vtext.com; 8018153497@tmomail.net; 4153083267@vtext.com; 7349044463@vtext.com; 8014198393@vtext.com; 8017926463@messaging.sprintpcs.com'	--Tad, Bob, Keith, BJ, Mike, Robert, Dave, Craig, Dale, Thayn, Gavin, Wi, Scott, Matt J, Weston, Mathew, Ervin, Nate, Joel 
		, @subject = @bodyActionText02 								--'Monitor' 



				

	END



--Contention, Unable to Identify
	IF ( @blockedValue > 0 AND @waitTimeValue > 0 )
	BEGIN
		DECLARE @xml03 		NVARCHAR(MAX)
		DECLARE @body03 	NVARCHAR(MAX)


		SET @xml03 = CAST(( 


		SELECT
				hostName			AS 'td','',
				spid				AS 'td','',
				blocked				AS 'td','',
				status				AS 'td','',
				waitTime			AS 'td','',
				program_Name		AS 'td','',
				cmd					AS 'td','',
				loginame			AS 'td','',
				cpu					AS 'td','',
				memUsage			AS 'td','',
				sqlText				AS 'td'
		FROM 
				@dTT01

		ORDER BY blocked, waitTime, cmd, spid	 ASC	
		

		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


		SET @body03 =
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
		cpu					</th><th>
		memUsage			</th><th>
		sqlText				</th></tr>
		'    

		 
		SET @body03 = @body03 + @xml03 +'</table></body></html>'

		
		--
		DECLARE @blockName03				varchar(max)
		DECLARE @spid03						varchar(max)


		DECLARE @bodyActionEmail03			varchar(max)
		DECLARE @bodyActionEmail03Min		varchar(max)
		DECLARE @bodyActionEmail03Max		varchar(max)
		DECLARE	@bodyExplain03				varchar(max)
		DECLARE @bodyActionText03			varchar(max)

		SET		@blockName03			=	( SELECT hostName							FROM @dTT01		WHERE rowId = 1 )
		SET		@spid03					=	( SELECT spid								FROM @dTT01		WHERE rowId = 1 )		
		SET 	@bodyActionEmail03Min	=	( SELECT cast(min(waitTime)/1000 as int)	FROM @dTT01 )
		SET 	@bodyActionEmail03Max	=	( SELECT cast(max(waitTime)/1000 as int)	FROM @dTT01 )
		SET		@bodyActionEmail03		=	'Contention, Unable to Identify; WaitTimes ' + @bodyActionEmail03Min + ' - ' + @bodyActionEmail03Max + ' sec'
		SET		@bodyActionText03		=	'Contention = '+ @blockName03
		SET		@bodyExplain03 			=	'spid = '+ @spid03





		--Sends email regarding details of issue
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Monitor' -- replace with your SQL Database Mail Profile 
		, @body = @body03
		, @body_format ='HTML'
		--, @recipients = 'tpeterson@mshare.net; bluther@mshare.net; kmciff@mshare.net' -- Tad; Bob; Keith
		, @recipients =	'dba@mshare.net' --; developers@mshare.net; bluther@mshare.net; kmciff@mshare.net' 	-- Developers Email; Developers Cell
		, @copy_recipients = 'tpeterson@mshare.net'

		, @subject = @bodyActionEmail03 ;


		--Sends text regarding details of issue
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Monitor'								-- replace with your SQL Database Mail Profile 
		, @body = @bodyExplain03
		, @recipients = '; 8016786926@vtext.com; ' 	-- Tad; Bob; Keith
		--, @recipients = '; 8016786926@vtext.com; 8017066481@tmomail.com; 8018287756@vtext.com; 8016784028@vmobl.com; 8016715144@vtext.com; 8014722353@vtext.com; 8014503052@VTEXT.COM; 8013620541@txt.att.net; 8015927788@vtext.com; 8018000200@tmomail.net; 8013723836@vtext.com; 8018034925@vtext.com; 8018153497@tmomail.net; 4153083267@vtext.com; 7349044463@vtext.com; 8014198393@vtext.com; 8017926463@messaging.sprintpcs.com'	--Tad, Bob, Keith, BJ, Mike, Robert, Dave, Craig, Dale, Thayn, Gavin, Wi, Scott, Matt J, Weston, Mathew, Ervin, Nate, Joel 
		, @subject = @bodyActionText03 								--'Monitor' 






				

	END




END	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
