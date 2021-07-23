SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE sp_TableUsage_vTad
	AS

/**********************  Last Time A Table Was Updated  ****************************

		Note: sys.dm_db_index_usage_stats is from last time sqlServer service 
		was cycled or failed over, causing a cycle of the service.  So a NULL
		value does not guarantee it has never been updated.
		

		Execute on Doctor sp_TableUsage_vTad


***********************************************************************************/

DECLARE @xml NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)


SET @xml = CAST(( 


SELECT 
		DISTINCT t03.name											
																AS 'td','',
		CONVERT( CHAR(8), MAX(t01.last_user_update), 112 )		
																AS 'td'
		
FROM 
		sys.dm_db_index_usage_stats		t01
	JOIN
		sysindexes						t02
			ON t01.object_id = t02.id
	JOIN
		sys.tables						t03
			ON t02.id = t03.object_id	
		
WHERE
		t03.name NOT LIKE '%/_%' ESCAPE '/'
	AND
		t03.NAME NOT LIKE 'sysdiagrams'
	AND
		t03.NAME NOT LIKE 'sysreplservers'
	AND
		t03.NAME NOT LIKE 'sysschemaarticles'
	AND
		t03.NAME NOT LIKE 'systranschemas'
	AND
		t03.NAME NOT LIKE 'sysarticleupdates'
	AND
		t03.NAME NOT LIKE 'sysarticleupdates'
	AND
		t03.NAME NOT LIKE 'sysarticlecolumns'
	AND
		t03.NAME NOT LIKE 'syssubscriptions'
	AND
		t03.NAME NOT LIKE 'sysarticles'
	AND
		t03.NAME NOT LIKE 'syspublications'
	AND
		t03.NAME NOT LIKE 'MSreplication%'
	AND
		t03.NAME NOT LIKE 'MSsubscription%'
	AND
		t03.NAME NOT LIKE 'MSpeer%'
	AND
		t03.NAME NOT LIKE 'MSpub%'
	AND
		t03.NAME NOT LIKE 'dtproperties'
	AND
		t03.NAME NOT LIKE 'datafieldoptionbak'		
	AND
		t03.NAME NOT LIKE '%McDonalds%'
	AND	
		t03.NAME NOT LIKE 'WC%'
	AND	
		t03.NAME NOT LIKE 'STA%'
	AND
		t03.NAME NOT LIKE '%Ontario%'
	AND
		t03.NAME NOT LIKE '%Hertz%'
	AND
		t03.NAME NOT LIKE 'TMP%'		
	AND	
		t03.NAME NOT LIKE 'ProductionStats'
	AND	
		t03.NAME NOT LIKE 'IHOP_Fraud_History'		
	AND	
		t03.NAME NOT LIKE 'latency%'
	AND	
		t03.NAME NOT LIKE '%DbTest%'
	AND	
		t03.NAME NOT LIKE '%feedbackchannelbak%'
	AND	
		t03.NAME NOT LIKE '%useraccount_audit%'
	AND
		t03.NAME NOT LIKE 'test'
	AND	
		t03.name LIKE '%[A-Z]'
					
GROUP BY
		t03.name						
		
ORDER BY
		CONVERT( CHAR(8), MAX(t01.last_user_update), 112 )		ASC
		, t03.name
		
		



FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))




SET @body =
'<html><body><H3>
Table Usage Since Last Cycle Of Sql Server Service	
						</H3><table border = 1><tr><th> 
Table Name					</th><th> 
Last Updated				</th></tr>
'    

 
SET @body = @body + @xml +'</table></body></html>'


EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'Notification', -- replace with your SQL Database Mail Profile 
@body = @body,
@body_format ='HTML',
@recipients = 'tpeterson@mshare.net', -- replace with your email address
@subject = 'OLTP Table Usage' ;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
