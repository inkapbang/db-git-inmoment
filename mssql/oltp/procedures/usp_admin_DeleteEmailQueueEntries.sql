SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_DeleteEmailQueueEntries] (@beginDate DATETIME, @endDate DATETIME, @batchsize int)--numberofEmailsToDelete)
AS
set nocount on;
/* modified by Bob Luther Jan 28,2008*/

BEGIN
	DECLARE @queue TABLE (objectId INT, attachmentObjectId INT)
	-- TODO: Once the queue is caught up, remove the top 50000 limit from the below SQL
	INSERT INTO @queue (objectId, attachmentObjectId)
		SELECT top 50000 objectId, attachmentObjectId FROM EmailQueue with (nolock) WHERE creationDateTime BETWEEN @beginDate AND @endDate

	set rowcount @batchsize
	
	delete from emailqueue with (rowlock) where objectid in (select objectId from @queue)
--	delete from binarycontent with (rowlock) where objectid in 
--		(select attachmentObjectId from @queue where attachmentObjectid in
--			(select top (@batchsize) attachmentobjectid from @queue where attachmentobjectid is not null)
--		)
	
	set rowcount 0

end --proc
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
