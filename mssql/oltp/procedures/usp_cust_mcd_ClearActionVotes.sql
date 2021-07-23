SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_mcd_ClearActionVotes]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- set vars
	declare @actionobjectid as int
	declare @actionVoteObjectId as int, @processed as int, @count as int

	-- get the action to be processed
	select top 1 @actionobjectid = objectid from _McDonalds_Action_DBA4587 where processed = 0 order by objectid

	-- temp table
	select actionVoteObjectId, processed 
	into #deletes
	from _McDonalds_ActionVote_DBA4587 
	where actionobjectid = @actionobjectid and processed = 0


	-- get the actionvotes to be processed in a cursor
	declare cur cursor for 
	select actionVoteObjectId, processed from #deletes

	set @count = 0

	open cur
	fetch next from cur into @ActionVoteObjectId, @processed
	while @@FETCH_STATUS = 0
	begin
--	/*
		-- do the deletes of those actionvotes
		delete from ActionVote with (rowlock)
		where objectid = @ActionVoteObjectId
		
		-- update the processed flags for the ActionVote 
		update _McDonalds_ActionVote_DBA4587 with (rowlock)
		set processed = 1
		where actionvoteobjectid = @ActionVoteObjectId

	--*/	
		-- get next
		fetch next from cur into @ActionVoteObjectId, @processed

		set @count += 1
	end

	close cur
	deallocate cur

--	/*
	-- do the delete of the action
	delete from Action with (rowlock) where objectid = @actionobjectid

	-- update the processed flag for the Action
	update _McDonalds_Action_DBA4587 with (rowlock)
	set processed = 1
	where objectid = @actionobjectid

	--*/

	drop table #deletes

	print cast(@count as varchar) + ' records processed.'

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
