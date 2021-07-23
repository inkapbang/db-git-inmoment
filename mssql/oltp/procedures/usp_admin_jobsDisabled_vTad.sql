SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_jobsDisabled_vTad]
	
AS

/**********************  Disabled Jobs Notification Production  **********************

	Runs on Doctor Mindshare OLTP
		usp_admin_jobsDisabled_vTad

*************************************************************************************/

-----Jobs Disabled
DECLARE @dTT01 TABLE
	(
		jobName			varchar(255)
		, enabled		varchar(3)
		, serverName	varchar(25)
	)
	
	

INSERT INTO @dTT01
SELECT 		
		DISTINCT j.name 									AS jobName
		, CASE enabled WHEN 0 THEN 'No' ELSE 'Yes' END		AS enabled
		, 'Doctor' 											AS serverName
		
FROM
		msdb.dbo.sysjobs j

WHERE
		enabled = 0	


UNION ALL

		
SELECT 		
		DISTINCT j.name 									AS jobName
		, CASE enabled WHEN 0 THEN 'No' ELSE 'Yes' END		AS enabled
		, 'Roy' 											AS serverName
		
FROM
		Roy.msdb.dbo.sysjobs j

WHERE
		enabled = 0	

		
--UNION ALL


--SELECT 		
--		DISTINCT j.name 									AS jobName
--		, CASE enabled WHEN 0 THEN 'No' ELSE 'Yes' END		AS enabled
--		, 'Chest' 											AS serverName
		
--FROM
--		Chest.msdb.dbo.sysjobs j

--WHERE
--		enabled = 0	
		
		
--UNION ALL


--SELECT 		
--		DISTINCT j.name 										AS jobName
--		, CASE enabled WHEN 0 THEN 'No' ELSE 'Yes' END			AS enabled
--		, 'Treasure' 											AS serverName
		
--FROM
--		Treasure.msdb.dbo.sysjobs j

--WHERE
--		enabled = 0	

		
--UNION ALL


--SELECT 		
--		DISTINCT j.name 										AS jobName
--		, CASE enabled WHEN 0 THEN 'No' ELSE 'Yes' END			AS enabled
--		, 'Cannonball' 												AS serverName
		
--FROM
--		Cannonball.msdb.dbo.sysjobs j

--WHERE
--		enabled = 0	
		
--UNION ALL


--SELECT 		
--		DISTINCT j.name 										AS jobName
--		, CASE enabled WHEN 0 THEN 'No' ELSE 'Yes' END			AS enabled
--		, 'Bat' 												AS serverName
		
--FROM
--		Bat.msdb.dbo.sysjobs j

--WHERE
--		enabled = 0	

		
-----Jobs Disabled Check and email
DECLARE	@count	int
SET		@count	=	( SELECT count(1)	FROM @dTT01 )


IF @count > 0
BEGIN
		-------Sends email regarding details of issue
		DECLARE @xml NVARCHAR(MAX)
		DECLARE @body NVARCHAR(MAX)


		SET @xml = CAST(( 



		SELECT 				
				jobName			AS 'td','',
				enabled			AS 'td','',
				serverName		AS 'td'
		FROM  
				@dTT01




		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))




		SET @body =
		'<html><body><H3>
		Disabled Jobs For Yesterday	
								</H3><table border = 1><tr><th>  
		Job Name					</th><th> 
		Enabled						</th><th> 
		Server Name 				</th></tr>
		'    

		 
		SET @body = @body + @xml +'</table></body></html>'


		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Notification' -- replace with your SQL Database Mail Profile 
		, @body = @body
		, @body_format ='HTML'
		, @recipients = 'tpeterson@mshare.net; bluther@mshare.net; kmciff@mshare.net' -- replace with your email address
		, @subject = 'Disabled Jobs For Yesterday' ;






END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
