SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_NotifyLatency]
@latencyThreshold int,
@except nvarchar(25)
AS
BEGIN
	DECLARE @count int
    DECLARE @alertMessage VARCHAR(2000)
	DECLARE @delim char(1)
	SET @delim = CHAR(9)

/****** Object:  Table [dbo].[_repl_latency]    Script Date: 12/15/2008 17:09:25 ******/

	exec [dbo].[usp_admin_checkReplicationLatency] @latencyThreshold,@except
	select	@count = count(*) 
	from dbo._replicationlatency 
	where Subscriber <> @except 
	and overalllatency >@latencyThreshold 
	or overalllatency is null
	and subscriberDB !='MindshareTwo'
	and subscriber !='Ape'

	if @count > 0
	begin
		SET @alertMessage = 
		'Replication Delay!' + CHAR(13) +
        'Check status email for more info.'

--		EXEC msdb.dbo.sp_send_dbmail
--		@profile_name = 'Alert', 
----		@recipients = 'jsperry@mshare.net;kwilliams@mshare.net;dnewbold@mshare.net;8016786926@vtext.com;mshare@mailman.xmission.com',
--	@recipients = 'alert@mshare.net',
--		@subject = 'Production Replication is slow! ',
--		@body = @alertMessage,
--		@importance = 'High'
		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		--@recipients = 'jsperry@mshare.net;kwilliams@mshare.net;dnewbold@mshare.net;bluther@mshare.net;mshare@mailman.xmission.com',
		--@recipients = 'mshare@mailman.xmission.com;8016786926@vtext.com',
		@recipients = '8016786926@vtext.com;',
		@subject = 'Replication is behind ',
		@body = 'Replication is at least 10 minutes behind'		--@query = 'select * from _ReplicationLatency where overalllatency >@lthreshold or overalllatency is null' ,
		--@query_result_width = 32767,
		--@exclude_query_output = 1,
		--@execute_query_database = 'mindshare',
		--@attach_query_result_as_file = 1,
		--@query_result_separator = @delim,
		--@query_attachment_filename = 'ReplicationSlow.csv',
		--@importance = 'High'
	end
END

--exec [dbo].[usp_admin_NotifyLatency] 6, 'ape'

---select *  from dbo._replicationlatency 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
