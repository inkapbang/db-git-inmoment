SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Proc [dbo].[usp_admin_DeliveryQueue_Master]
AS
BEGIN
	DECLARE @count int
    DECLARE @alertMessage VARCHAR(2000)
	DECLARE @delim char(1)
	SET @delim = CHAR(9)

	select	@count =  COUNT(*) FROM ACTIVEMQDB.dbo.ACTIVEMQ_MSGS

	if @count > 0
	begin
		SET @alertMessage =
		'There are '+cast(@count as varchar) +' Unsent Pages in the Queue!' 

		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = 'mshare@mailman.xmission.com',
		@subject = 'Unsent Pages in queue',
		@body = @alertMessage,
		@importance = 'High'
		
	end
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
