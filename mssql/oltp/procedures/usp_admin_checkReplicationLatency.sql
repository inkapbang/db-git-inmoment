SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_admin_checkReplicationLatency] 
@lthreshold int,
@exception varchar(50)
as

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_replicationlatency]') AND type in (N'U'))
Begin
	create table _ReplicationLatency(
	distributorLatency int,
	Subscriber Nvarchar(50),
	subscriberDB nvarchar(50),
	subscriberLatency int,
	overalllatency int)
	end

DECLARE @publication AS sysname;
DECLARE @tokenID AS int;
SET @publication = N'DoctorMindsharePub'; 

-- Insert a new tracer token in the publication database.
EXEC sys.sp_posttracertoken 
  @publication = @publication,
  @tracer_token_id = @tokenID OUTPUT;
--SELECT 'The ID of the new tracer token is ''' + 
--	CONVERT(varchar,@tokenID) + '''.'
--GO

-- Wait 10 seconds for the token to make it to the Subscriber.
--WAITFOR DELAY '00:00:10';
WAITFOR DELAY '00:09:00';
--GO

-- Get latency information for the last inserted token.
CREATE TABLE #tokens (tracer_id int, publisher_commit datetime)

-- Return tracer token information to a temp table.
INSERT #tokens (tracer_id, publisher_commit)
EXEC sys.sp_helptracertokens @publication = @publication;
SET @tokenID = (SELECT TOP 1 tracer_id FROM #tokens
ORDER BY publisher_commit DESC)
DROP TABLE #tokens

-- Get history for the tracer token.
truncate table dbo._replicationlatency
insert into dbo._replicationlatency
EXEC sys.sp_helptracertokenhistory 
  @publication = @publication, 
  @tracer_id = @tokenID;
delete from dbo._replicationLatency where Subscriber=@exception
--GO

--select * from dbo._replicationlatency where overalllatency >@lthreshold or overalllatency is null

--exec dbo.usp_admin_checkReplicationLatency 6,'ape'
select * from _ReplicationLatency
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
