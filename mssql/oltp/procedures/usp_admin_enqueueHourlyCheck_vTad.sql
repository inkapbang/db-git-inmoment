SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_enqueueHourlyCheck_vTad]	AS 
--exec usp_admin_enqueueHourlyCheck_vTad
-----sp_admin_enqueueHourlyCheck
---------scheduled 20 past the hour
		
							


DECLARE @lastScheduledTime		INT
		, @currentTime			INT
		
		
		
SET		@lastScheduledTime 	= (	SELECT DATEPART(hh, startTime)	FROM deliveryRunLogEntry	WHERE objectId = ( SELECT	MAX(objectId)	FROM deliveryRunLogEntry )	)

SET 	@currentTime		= (	SELECT 	DATEPART(hh, getDate())	)



IF @lastScheduledTime != @currentTime
BEGIN
		-------Sends text & email regarding details of issue
		DECLARE @deliveryValue	varchar(max)
		DECLARE @bodyAction		varchar(max)
		DECLARE	@bodyExplain	varchar(max)
		DECLARE	@bodyExplain2	varchar(max)

		SET		@deliveryValue	=	@currentTime
		SET		@bodyAction		=	'Enqueue Hour '+ cast(@deliveryValue as varchar)+ ' Failed or Delayed' 
		SET		@bodyExplain 	=	'#&%@*!^#$'
		SET		@bodyExplain2	=	'Please remedy failure or delay'

		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Notification'							-- replace with your SQL Database Mail Profile 
		, @body = @bodyExplain
		, @recipients = '; 8016786926@vtext.com' 	-- Tad, Dale
		--, @recipients = ''	--Tad Only
		, @subject = @bodyAction;
		
		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert'							-- replace with your SQL Database Mail Profile 
		, @body = @bodyExplain2
		, @recipients = 'bluther@InMoment.com;developers@mshare.net' 
		--, @recipients = 'tpeterson@mshare.net' 		--Tad Only
		, @subject = @bodyAction;

	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
