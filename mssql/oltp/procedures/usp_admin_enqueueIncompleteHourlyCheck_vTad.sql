SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_enqueueIncompleteHourlyCheck_vTad]	AS



-----usp_admin_enqueueIncompleteHourlyCheck_vTad
---------scheduled 05 past the hour
		
							


DECLARE @check		varchar(100)
		
		
		
SET		@check 	= (	SELECT endTime	FROM deliveryRunLogEntry	WHERE objectId = ( SELECT	MAX(objectId)	FROM deliveryRunLogEntry )	)








IF @check IS NULL
BEGIN
		-------Sends text & email regarding details of issue
		
		DECLARE @bodyAction		varchar(max)
		DECLARE	@bodyExplain	varchar(max)
		DECLARE	@bodyExplain2	varchar(max)

		
		SET		@bodyAction		=	'Warning, Delivery Enqueue Not Finished' 
		SET		@bodyExplain 	=	'#&%@*!^#$'
		SET		@bodyExplain2	=	'Please remedy failure or delay'

		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Notification'							-- replace with your SQL Database Mail Profile 
		, @body = @bodyExplain
		, @recipients = '; 8014503052@vtext.com' 	-- Tad, Dale
		--, @recipients = ''	--Tad Only
		, @subject = @bodyAction;
		
		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Notification'							-- replace with your SQL Database Mail Profile 
		, @body = @bodyExplain2
		, @recipients = 'developers@mshare.net' 
		--, @recipients = 'tpeterson@mshare.net' 		--Tad Only
		, @subject = @bodyAction;

	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
