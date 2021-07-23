SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_AccessEventLog_Notification_vTad]
AS

/********************************  Access Event Log Notification  ********************************

	usp_admin_AccessEventLog_Notification
	
	This is a notification that shows how many old entries will be deleted in the job 
	scheduled to run later in the evening.  It gives you a change to disable/postpone
	job for a more appropiate time.
	


**************************************************************************************************/



DECLARE	@deleteValue	varchar(50)

SET		@deleteValue	= ( SELECT REPLACE(CONVERT(varchar(20), (CAST( COUNT(1)  AS money)), 1), '.00', '')		FROM accessEventLog		WHERE timeStamp < DATEADD( m, -6, DATEADD( d, -(DATEPART(d, getDate())-1), CAST(FLOOR(CAST( getDate() AS float)) AS dateTime))) )


DECLARE @xml01 		NVARCHAR(MAX)
DECLARE @body01 	NVARCHAR(MAX)


SET @xml01 = CAST(( 


SELECT	@deleteValue				AS 'td'


FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


SET @body01 =
											'<html><body><H3>
Access Event Log Table	
											</H3><table border = 1><tr><th> 
Delete Count For Job Execution Tonight		</th></tr>
'    

 
SET @body01 = @body01 + @xml01 +'</table></body></html>'


--
DECLARE @bodyActionEmail01		varchar(max)
DECLARE @bodyActionText01		varchar(max)
DECLARE	@bodyExplain01			varchar(max)

SET		@bodyActionEmail01	=	'Rows To Be Delete Tonight = '+ @deleteValue
SET		@bodyActionText01	=	'AccessEventLog Deleting '+ @deleteValue + ' rows tonight'
SET		@bodyExplain01		=	'Scheduled Job will be deleting this many rows tonight on OLTP'



--Sends email regarding details of issue
EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'Monitor' -- replace with your SQL Database Mail Profile 
, @body = @body01
, @body_format ='HTML'
, @recipients = 'tpeterson@mshare.net; bluther@mshare.net; kmciff@mshare.net' -- Tad; Bob
--, @recipients =	'developers@mshare.net; mshare@mailman.xmission.com' 	-- Developers Email; Developers Cell
, @subject = @bodyActionEmail01 ;
		



--Sends text regarding details of issue
EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'Monitor'								-- replace with your SQL Database Mail Profile 
, @body = @bodyExplain01
, @recipients = '; 8016786926@vtext.com; ' 	-- Tad; Bob
--, @recipients = '; 8016786926@vtext.com; 8018287756@vtext.com; 8016784028@vmobl.com; 8016715144@vtext.com; 8014722353@vtext.com; 8012581964@txt.att.net; 8014503052@VTEXT.COM; 8013620541@txt.att.net; 8015927788@vtext.com; 8018000200@tmomail.net; 8013723836@vtext.com; 8018034925@vtext.com'	--Tad, Bob, BJ, Mike, Robert, Dave, Craig, Dale, Thayn, Gavin, Wi, Scott, Matt J 
, @subject = @bodyActionText01 								--'Monitor' 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
