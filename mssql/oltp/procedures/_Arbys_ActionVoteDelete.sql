SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE _Arbys_ActionVoteDelete
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- DBA-6549

/*
select * from organization (nolock)
where name like 'arby%'
--1491

--*/

-- goal: determine items from ActionVote that need to be deleted, preserving the most recent items (always), and up to 6 months historical data.
-- TESTING: store all items we intend to delete
/*
create table _Arbys_DeleteBlocks (ActionVoteId int, OrganizationalUnitId int, vote int, createdDateTime datetime
	, ActionId int, ActionLabel nvarchar(MAX), ActionGroupId int, ActionGroupName nvarchar(200), datafieldObjectId int
	, datafieldoptionobjectid int, UpliftModelId int, UpliftModelName varchar(100), isDeleteTarget bit, preventDelete bit
	, isDeleted bit default 0
	)

create index idx_flags on _Arbys_DeleteBlocks (isDeleteTarget, preventDelete, isDeleted)
go
create index idx_keys on _Arbys_DeleteBlocks (ActionVoteId, isDeleteTarget, preventDelete, isDeleted)
go
	
--drop table _Arbys_DeleteBlocks

truncate table _Arbys_DeleteBlocks
--*/



-- get current date
declare @currentDate smalldatetime, @referenceDate smalldatetime
select @currentDate = cast(floor(cast(getDate() as float)) as smalldatetime)
select @referenceDate = dateadd(day, -182, @currentDate) -- 6 months is 182 days

declare @OrganizationalUnitId int

-- testing
--select @currentDate, @referenceDate

-- get list of organizationalUnitIds
select distinct av.unitObjectId as OrganizationalUnitId
into #units
from actionvote (nolock) av
inner join action (nolock) a on a.objectid = av.actionObjectId
left outer join localizedStringValue (nolock) lsv on lsv.localizedStringObjectid = a.labelObjectid and lsv.localekey = 'en_us'
inner join actiongroup (nolock) ag on ag.objectid = a.actiongroupobjectid
inner join upliftmodelactiongroup (nolock) umag on umag.actiongroupobjectid = ag.objectid
inner join upliftmodel (nolock) um on um.objectid = umag.upliftmodelobjectid
where ag.organizationobjectid = 1491

declare @loop int, @maxItems int
set @loop = 0
set @maxItems = 5

select top 1 @OrganizationalUnitId = u.organizationalUnitId 
from #units u
where not exists (select top 1 organizationalunitid from _Arbys_DeleteBlocks b where b.isdeleted = 1 and b.organizationalunitid = u.organizationalunitid)

-- testing
select @OrganizationalUnitId as OrganizationalUnitIdForDelete

while @OrganizationalUnitId is not null and @loop < @maxItems
begin
	-- testing
	--select @OrganizationalUnitId


	-- setup holding table
	/*
	create table _Arbys_ActionVoteProcessing (ActionVoteId int, OrganizationalUnitId int, vote int, createdDateTime datetime
		, ActionId int, ActionLabel nvarchar(MAX), ActionGroupId int, ActionGroupName nvarchar(200), datafieldObjectId int
		, datafieldOptionObjectId int, UpliftModelId int, UpliftModelName varchar(100)
		, isDeleteTarget bit default 0, preventDelete bit default 0
		)

	drop table 	_Arbys_ActionVoteProcessing
	--*/
	truncate table _Arbys_ActionVoteProcessing

	-- get every vote, for every action
	--/*
	-- determine "most recent" vote per item, per location, per model
	insert into _Arbys_ActionVoteProcessing (ActionVoteId, OrganizationalUnitId, vote, createdDateTime, ActionId
		, ActionLabel, ActionGroupId, ActionGroupName, datafieldObjectId, datafieldOptionObjectId
		, UpliftModelId, UpliftModelName)
	select av.objectId as ActionVoteId, av.unitObjectId as OrganizationalUnitId, av.vote, av.createdDateTime
	, a.objectid as ActionId, lsv.value as ActionLabel
	, ag.objectId as ActionGroupId, ag.name as ActionGroupName, ag.datafieldobjectid, ag.datafieldoptionobjectid
	, um.objectId as UpliftModelId, um.name as UpliftModelName
	from actionvote (nolock) av
	inner join action (nolock) a on a.objectid = av.actionObjectId
	left outer join localizedStringValue (nolock) lsv on lsv.localizedStringObjectid = a.labelObjectid and lsv.localekey = 'en_us'
	inner join actiongroup (nolock) ag on ag.objectid = a.actiongroupobjectid
	inner join upliftmodelactiongroup (nolock) umag on umag.actiongroupobjectid = ag.objectid
	inner join upliftmodel (nolock) um on um.objectid = umag.upliftmodelobjectid
	where ag.organizationobjectid = 1491
	-- test limits by organizationalUnitId
	and av.unitObjectId = @OrganizationalUnitId -- organizationalunit
	--and av.unitObjectId = 1331188 -- organizationalunit

	--order by av.unitObjectId, lsv.value, ag.name, um.name, av.createdDateTime
	--*/

	-- testing
	--select * from _Arbys_ActionVoteProcessing
	-- sorting too difficult, do not attempt with this volume
	--order by OrganizationalUnitId, ActionLabel, ActionGroupName, UpliftModelName, createdDateTime


	-- determine the set of items that may be too old
	update p
	set p.isDeleteTarget = 1
	from _Arbys_ActionVoteProcessing p
	where p.createdDatetime < @referenceDate

	-- testing
	--select * from _Arbys_ActionVoteProcessing

	-- determine most recent item per organizationUnit, action, actiongroup, uplift model
	select p.actionVoteId, p.organizationalunitid, p.actionid, p.actiongroupid, p.datafieldobjectid, p.datafieldoptionobjectid, p.upliftmodelid
	, dense_rank() over (partition by p.organizationalunitid, p.actionid, p.actiongroupid, p.datafieldobjectid, p.datafieldoptionobjectid, p.upliftmodelid order by p.createddatetime desc) as rnk
	, isDeleteTarget
	into #rankedItems
	from _Arbys_ActionVoteProcessing p
	order by p.organizationalunitid, p.actionid, p.actiongroupid, p.datafieldobjectid, p.datafieldoptionobjectid, p.upliftmodelid, rnk

	-- testing
	--select * from #rankedItems

	-- Note: We should only delete items marked as delete targets, unless those items are also marked as prevent deletes
	-- if an item is rnk = 1 and is marked as a delete target, then we need to prevent the deletion of that item, as it is 
	--		the most recent item (even though it has aged out).
	update p
	set p.preventDelete = 1
	from _Arbys_ActionVoteProcessing p
	inner join #rankedItems r on r.actionVoteId = p.actionVoteId
	where r.rnk = 1
	and r.isdeletetarget = 1

	-- testing
	--select * from _Arbys_ActionVoteProcessing

	-- record items to delete.  Delete only items marked isDeleteTarget = 1 and preventDelete = 0
	insert into _Arbys_DeleteBlocks(ActionVoteId, OrganizationalUnitId, vote, createdDateTime, ActionId
	, ActionLabel, ActionGroupId, ActionGroupName, datafieldObjectId, datafieldoptionobjectid, UpliftModelId
	, UpliftModelName, isDeleteTarget, preventDelete)
	select ActionVoteId, OrganizationalUnitId, vote, createdDateTime, ActionId
	, ActionLabel, ActionGroupId, ActionGroupName, datafieldObjectId, datafieldoptionobjectid, UpliftModelId
	, UpliftModelName, isDeleteTarget, preventDelete
	from _Arbys_ActionVoteProcessing p
	where p.isDeleteTarget = 1 and p.preventDelete = 0


	-- update the loop conditions
	drop table #rankedItems

	delete from #units where organizationalUnitId = @OrganizationalUnitId

	select top 1 @OrganizationalUnitId = u.organizationalUnitId 
	from #units u
	where not exists (select top 1 organizationalunitid from _Arbys_DeleteBlocks b where b.isdeleted = 1 and b.organizationalunitid = u.organizationalunitid)

	-- testing
	select @OrganizationalUnitId as OrganizationalUnitIdForDelete

	select @loop = @loop + 1
end

-- testing
select * from _Arbys_DeleteBlocks 
where isDeleteTarget = 1 and preventDelete = 0 and isDeleted = 0

-- do the deletion step
--/*
-- cursor processing
declare @VoteId int
declare delCursor cursor for
	select ActionVoteId from _Arbys_DeleteBlocks
	where isDeleteTarget = 1 and preventDelete = 0 and isDeleted = 0

open delCursor
fetch next from delCursor into @VoteId

while @@FETCH_STATUS=0
begin
	begin
		delete
		from ActionVote
		where objectid = @VoteId

		if(@@ROWCOUNT=0) print 'failed to delete'
	end

	fetch next from delCursor into @VoteId
end

close delCursor
deallocate delCursor
--*/

/*
delete av
--select *
from ActionVote av
inner join _Arbys_DeleteBlocks b on b.actionvoteid = av.objectid
where b.isDeleteTarget = 1 and b.preventDelete = 0 and b.isDeleted = 0

--*/

-- update the deleted items
update _Arbys_DeleteBlocks
set isDeleted = 1

-- cleanup
--drop table #rankedItems
drop table #units

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
