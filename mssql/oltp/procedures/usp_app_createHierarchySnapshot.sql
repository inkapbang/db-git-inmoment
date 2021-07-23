SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_app_createHierarchySnapshot]
	@targetHierarchySnapshotId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- purpose: DBA-9301 - clone a hierarchy snapshot
	-- created: 20210518
	-- author: TAR

	-- create hierarchy snapshot
	-- get information from current snapshot
	declare @snapshotId int
	set @snapshotId = @targetHierarchySnapshotId

	declare @isCurrent bit
	declare @currentSnapshotId bigint
	declare @organizationId bigint
	declare @hierarchyId bigint
	declare @status int
	declare @msg varchar(max)


	/* action: check requested snapshot is in correct state */
	-- get hierarchy and organization
	select @hierarchyId = hs.hierarchyobjectid
	, @organizationId = hs.organizationobjectid
	, @status = hs.status
	, @isCurrent = hs.isCurrent
	from hierarchySnapshot (nolock) hs
	where hs.objectId = @snapshotId
	order by startDate desc

	-- requested snapshot exists?
	if @hierarchyId is null
	begin
		-- raise error
		set @msg = 'Cannot Clone Hierarchy: Hierarchy Snapshot Not Found.'
		raiserror(@msg , 16, 1)

		return
	end

	-- check this is not the current snapshot
	if @isCurrent = 1
	begin
		-- raise error
		set @msg = 'Cannot Clone Current Snapshot.'
		raiserror(@msg, 16, 1)
		
		return
	end

	-- check snapshot is in correct state
	if @status <> 0 -- CLONE status
	begin
		-- raise error
		set @msg = 'Cannot Clone Hierarchy: Requested Snapshot Not In Clone State.'
		raiserror(@msg , 16, 1)

		return
	end
		
	-- check for current snapshot
	select @currentSnapshotId = hs.objectid
	from hierarchysnapshot (nolock) hs
	where hs.hierarchyobjectid = @hierarchyid
	and hs.organizationobjectid = @organizationid
	and hs.iscurrent = 1

	-- current snapshot exists?
	if @currentSnapshotId is null
	begin
		-- raise error
		raiserror('Cannot Clone Hierarchy: No Current Hierarchy Snapshot Found.',16,1)
		return
	end

	-- testing
	--select @snapshotId as snapshotId, @currentSnapshotId as currentSnapshotId, @hierarchyId as hierarchyId, @organizationId as organizationId, @status as [status]
	--print 'HierarchySnapshot has available Current Parent HierarchySnapshot' return

	/* request has passed initial conditions, next step, collection of source records */

	/* action: lookup source records */
	/* source record lookups */

	-- lookup LocationCategoryType for Hierarchy 
	--		provides: source LocationCategoryType records
	declare @SourceLocationCategoryType table 
		(objectId int, organizationObjectId int, name varchar(50)
		, description varchar(2000), version int, hierarchyObjectId int
		, sequence int, reviewOptIn bit, reviewExpandChildren bit
		, dataSourceType int, externalId varchar(255)
		, snapshotFromLocationCategoryTypeObjectId int
		, hierarchySnapshotObjectId int)

	-- get source LocationCategory records
	insert into @SourceLocationCategoryType	
	select lct.objectId, lct.organizationObjectId, lct.name
		, lct.description, lct.version, lct.hierarchyObjectId
		, lct.sequence, lct.reviewOptIn, lct.reviewExpandChildren
		, lct.dataSourceType, lct.externalId
		, lct.snapshotFromLocationCategoryTypeObjectId
		, lct.hierarchySnapshotObjectId
	from locationcategorytype (nolock) lct
	where lct.hierarchyobjectid = @hierarchyId
	and lct.hierarchysnapshotobjectid = @currentSnapshotId
	and lct.snapshotfromlocationcategorytypeobjectid is null

	-- testing
	--select * from @SourceLocationCategoryType return


	-- lookup LocationCategory for each source LocationCategoryType
	--		provides: source LocationCategory records
	declare @SourceLocationCategory table
		(objectId int, name nvarchar(200), organizationObjectId int, parentObjectId int
		, depth tinyint, lineage varchar(255), LocationCategoryTypeObjectId int
		, version int, timeZone varchar(50), externalId varchar(255), rootObjectId int
		, leftExtent int, rightExtent int, reviewOptIn bit, reviewAggregate bit
		, reviewUrl varchar(100), brandObjectId int, lineageSort varchar(265)
		, snapshotFromLocationCategoryObjectId int)

	insert into @SourceLocationCategory
	select lc.objectId, lc.name, lc.organizationObjectId, lc.parentObjectId
		, lc.depth, lc.lineage, lc.LocationCategoryTypeObjectId
		, lc.version, lc.timeZone, lc.externalId, lc.rootObjectId
		, lc.leftExtent, lc.rightExtent, lc.reviewOptIn, lc.reviewAggregate
		, lc.reviewUrl, lc.brandObjectId, lc.lineageSort
		, lc.snapshotFromLocationCategoryObjectId
	from LocationCategory (nolock) lc
	inner join @SourceLocationCategoryType slct on slct.objectid = lc.locationcategorytypeobjectid

	-- testing
	--select * from @SourceLocationCategory return


	-- lookup UserAcountLocationCategory records
	--		provides: source UserAccountLocationCategory records
	declare @SourceUserAccountLocationCategory table
		(locationCategoryObjectId int, userAccountObjectId int)

	insert into @SourceUserAccountLocationCategory
	select ualc.locationCategoryObjectId, ualc.userAccountObjectId
	from UserAccountLocationCategory (nolock) ualc
	inner join @SourceLocationCategory slc on slc.objectid = ualc.locationcategoryobjectid

	-- testing
	--select * from @SourceUserAccountLocationCategory return


	-- lookup LocationCategoryLocation for source LocationCategoryLocation records
	--		provides: source LocationCategoryLocation records
	declare @SourceLocationCategoryLocation table
		(locationCategoryObjectId int, locationObjectId int, insertOrder bigint)
		
	insert into @SourceLocationCategoryLocation
	select lcl.locationCategoryObjectId, lcl.locationObjectId, lcl.insertOrder
	from locationcategorylocation (nolock) lcl
	inner join @SourceLocationCategory slc on slc.objectid = lcl.locationcategoryobjectid

	-- testing
	--select * from @SourceLocationCategoryLocation

	-- lookup Location for source LocationCategory records
	--		provides: source LocationCategory records
	declare @SourceLocation table
		(objectId int, name nvarchar(200), addressObjectId int, contactInfoObjectId int
		, organizationObjectId int, locationNumber varchar(50), hidden bit
		, startDate datetime, version int, enabled bit, nameInSurvey nvarchar(200)
		, vxml varchar(500), timeZone varchar(50), logoObjectId int, reviewOptIn bit
		, url varchar(1000), description varchar(4000), reviewUrl varchar(100)
		, facebook varchar(500), google varchar(500), yelp varchar(500), tripAdvisor varchar(500)
		, twitterHashtagHandle varchar(500), facebookPage varchar(500), googlePage varchar(500)
		, yelpPage varchar(500), tripAdvisorPage varchar(500), twitterHandle varchar(500)
		, searchedSocialLocations bit, unitCode varchar(50), socialIntegrationEnabled bit
		, exemptFromAutoDisable bit, brandObjectId int)

	insert into @SourceLocation
	select l.objectId, l.name, l.addressObjectId, l.contactInfoObjectId
		, l.organizationObjectId, l.locationNumber, l.hidden
		, l.startDate, l.version, l.enabled, l.nameInSurvey
		, l.vxml, l.timeZone, l.logoObjectId, l.reviewOptIn
		, l.url, l.description, l.reviewUrl
		, l.facebook, l.google, l.yelp, l.tripAdvisor
		, l.twitterHashtagHandle, l.facebookPage, l.googlePage
		, l.yelpPage, l.tripAdvisorPage, l.twitterHandle
		, l.searchedSocialLocations, l.unitCode, l.socialIntegrationEnabled
		, l.exemptFromAutoDisable, l.brandObjectId
	from location (nolock) l
	inner join @SourceLocationCategoryLocation slcl on slcl.locationobjectid = l.objectid

	-- testing
	--select * from @SourceLocation


	-- lookup UserAccountLocation records
	--		provides: source UserAccountLocation records
	declare @SourceUserAccountLocation table
		(userAccountObjectId int, locationObjectId int)

	insert into @SourceUserAccountLocation
	select ual.userAccountObjectId, ual.locationObjectId
	from UserAccountLocation (nolock) ual
	inner join @SourceLocation sl on sl.objectid = ual.locationobjectid

	-- testing
	--select * from @SourceUserAccountLocation return


	/* action: create snapshot records */
	-- create LocationCategoryType records for snapshot
	--		link to HierarchySnapshot and source LocationCategoryType

	/* *** run as single transaction *** */
	begin tran

	begin try

	insert into LocationCategoryType with (rowlock) (organizationObjectId, name, description, version, hierarchyObjectId, sequence, reviewOptIn, reviewExpandChildren, dataSourceType, externalId, snapshotFromLocationCategoryTypeObjectId, hierarchySnapshotObjectId)
	select slct.organizationObjectId
		, slct.name
		--, left(slct.name, 50-11) + ' (Snapshot)' as name
		, slct.description, slct.version, slct.hierarchyObjectId
		, slct.sequence, slct.reviewOptIn, slct.reviewExpandChildren, slct.dataSourceType, slct.externalId
		, slct.objectid as snapshotFromLocationCategoryTypeObjectId
		, @snapshotId as hierarchySnapshotObjectId
	from @sourceLocationCategoryType slct

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch

	-- create LocationCategory records for snapshot
	--		link to HierarchySnapshot and source LocationCategory
	/*** DO THIS:
	1. find roots from source
	2. insert roots, pointing copies to sources
	3. loop over depth:
		for every depth:
			1. find members from source, reference parents from source
			2. associate members to clone parent
			3. insert clone members
	***/

	-- find the roots for this hierarchy, and insert them into LocationCategory
	----begin tran

	begin try

	-- get roots
	insert into LocationCategory with (rowlock) (name, organizationObjectId, parentObjectId, depth, lineage
		, LocationCategoryTypeObjectId, version, timeZone, externalId
		, rootObjectId
		, leftExtent, rightExtent, reviewOptIn, reviewAggregate
		, reviewUrl, brandObjectId
		--, lineageSort
		, snapshotFromLocationCategoryObjectId)
	select slc.name --left(slc.name, 200-11) + ' (Snapshot)' as name
		, slc.organizationObjectId, slc.parentObjectId, slc.depth, slc.lineage
		, lct.objectid as LocationCategoryTypeObjectId, slc.version, slc.timeZone, slc.externalId
		, null as rootObjectId -- this will need updating in next step
		, slc.leftExtent, slc.rightExtent, slc.reviewOptIn, slc.reviewAggregate
		, slc.reviewUrl, slc.brandObjectId
		--, null as lineageSort -- this is calculated by the table
		, slc.objectid as snapshotFromLocationCategoryObjectId
	from @sourceLocationCategory slc
	inner join locationcategorytype lct on lct.snapshotfromlocationcategorytypeobjectid = slc.locationcategorytypeobjectid 
	where slc.depth = 0 -- root
	and lct.hierarchysnapshotobjectid = @snapshotId

	-- update roots with inserted objectid values
	update lc
		set lc.rootObjectId = lc.objectid -- this will need updating in next step
	from locationcategory lc
	inner join locationcategorytype lct on lct.objectid = lc.locationcategorytypeobjectid 
	where lc.depth = 0 -- root
	and lct.hierarchysnapshotobjectid = @snapshotId

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch


	-- with roots in place, iterate over the depth of the hierarchy, inserting LocationCategory records
	declare @depth int, @maxDepth int
	set @depth = 1 -- root = 0

	select @maxDepth = max(depth) from @sourceLocationCategory

	while @depth <= @maxDepth
	begin

	-- testing
	--select @depth as depth, @maxDepth as maxDepth

	begin try

	insert into LocationCategory with (rowlock) (name, organizationObjectId, parentObjectId, depth
		, lineage
		, LocationCategoryTypeObjectId, version, timeZone, externalId
		, rootObjectId
		, leftExtent, rightExtent, reviewOptIn, reviewAggregate
		, reviewUrl, brandObjectId
		, snapshotFromLocationCategoryObjectId)
	select slc.name --left(slc.name, 200-11) + ' (Snapshot)' as name
		, slc.organizationObjectId, plc.objectid as parentObjectId, slc.depth
		, plc.lineageSort + '/' as lineage
		, lct.objectid as LocationCategoryTypeObjectId, slc.version, slc.timeZone, slc.externalId
		, plc.rootObjectId
		, slc.leftExtent, slc.rightExtent, slc.reviewOptIn, slc.reviewAggregate
		, slc.reviewUrl, slc.brandObjectId
		, slc.objectid as snapshotFromLocationCategoryObjectId
	from @sourceLocationCategory slc
	inner join locationcategorytype lct on lct.snapshotfromlocationcategorytypeobjectid = slc.locationcategorytypeobjectid 
	inner join locationCategory plc on plc.snapshotfromlocationcategoryobjectid = slc.parentobjectid
	inner join locationcategorytype plct on plct.objectid = plc.locationcategorytypeobjectid
	where slc.depth = @depth
	and lct.hierarchysnapshotobjectid = @snapshotId
	and plct.hierarchysnapshotobjectid = @snapshotId

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch


	-- update loop condition
	set @depth = @depth+1
	end


	-- create OrganizationalUnit records
	begin try

	insert into OrganizationalUnit (version, locationCategoryObjectId)
	select 0 as version, lc.objectid as locationCategoryObjectId
	from LocationCategory lc
	inner join locationcategorytype lct on lct.objectid = lc.locationcategorytypeobjectid
		and lct.hierarchysnapshotobjectid = @snapshotId

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch


	-- create UserAccountLocationCategory records
	begin try

	insert into UserAccountLocationCategory with (rowlock) (locationCategoryObjectId, userAccountObjectId)
	select lc.objectid as locationcategoryObjectid, sualc.userAccountObjectId
	from @SourceUserAccountLocationCategory sualc
	inner join locationcategory lc on lc.snapshotfromlocationcategoryobjectid = sualc.locationcategoryobjectid
	inner join locationcategorytype lct on lct.objectid = lc.locationcategorytypeobjectid
		and lct.hierarchysnapshotobjectid = @snapshotId

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch


	-- create LocationCategoryLocation records for snapshot
	--		associate snapshot LocationCategory to Location to match with source LocationCategory to Location
	begin try

	insert into LocationCategoryLocation with (rowlock) (locationCategoryObjectId, locationObjectId)
	select lc.objectid as locationCategoryObjectId, slcl.locationObjectId
	from @sourcelocationcategorylocation slcl
	inner join locationcategory lc on lc.snapshotfromlocationcategoryobjectid = slcl.locationcategoryobjectid
	inner join locationcategorytype lct on lct.objectid = lc.locationcategorytypeobjectid
		and lct.hierarchysnapshotobjectid = @snapshotId

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch


	-- create UserAccountLocationSnapshot records
	--		associate back to snapshot id
	begin try

	insert into UserAccountLocationSnapshot with (rowlock) (userAccountObjectId, locationObjectId, hierarchySnapshotObjectId)
	select sual.userAccountObjectId, sual.locationObjectId, @snapshotId as hierarchySnapshotObjectId
	from @sourceUserAccountLocation sual

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch


	-- action: confirm creation counts
	declare @checkError bit
	set @checkError = 0

	declare @countSource int, @countClone int

	-- check LocationCategoryType
	select @countSource = count(*) from @SourceLocationCategoryType

	select @countClone = count(lct.objectId) 
	from locationcategorytype (nolock) lct
	where lct.hierarchysnapshotobjectid = @snapshotId

	-- check LocatioanCategoryType counts
	if @countSource <> @countClone
	begin
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = 'LocationCategoryType count does not match source table.'
		raiserror(@msg, 16, 1)
		
		return
	end


	-- check LocationCategory
	select @countSource = count(*) from @SourceLocationCategory

	select @countClone = count(lc.objectId)
	from locationcategory (nolock) lc
	inner join locationcategorytype (nolock) lct on lct.objectid = lc.locationcategorytypeobjectid
	where lct.hierarchysnapshotobjectid = @snapshotId

	-- check LocationCategoryType counts
	if @countSource <> @countClone
	begin
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = 'LocationCategory count does not match source table.'
		raiserror(@msg, 16, 1)
		
		return
	end


	-- check UserAccountLocationCategory
	select @countSource = count(*) from @SourceUserAccountLocationCategory 

	select @countClone = count(ualc.locationCategoryObjectId)
	from useraccountlocationcategory (nolock) ualc
	inner join locationcategory (nolock) lc on lc.objectid = ualc.locationcategoryobjectid
	inner join locationcategorytype (nolock) lct on lct.objectid = lc.locationcategorytypeobjectid
	where lct.hierarchysnapshotobjectid = @snapshotId

	-- check LocationCategoryType counts
	if @countSource <> @countClone
	begin
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = 'UserAccountLocationCategory count does not match source table.'
		raiserror(@msg, 16, 1)
		
		return
	end


	-- check LocationCategoryLocation
	select @countSource = count(*) from @SourceLocationCategoryLocation

	select @countClone = count(lcl.locationcategoryobjectid)
	from locationcategorylocation (nolock) lcl
	inner join locationcategory (nolock) lc on lc.objectid = lcl.locationcategoryobjectid
	inner join locationcategorytype (nolock) lct on lct.objectid = lc.locationcategorytypeobjectid
	where lct.hierarchysnapshotobjectid = @snapshotId

	-- check LocationCategoryLocation counts
	if @countSource <> @countClone
	begin
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = 'LocationCategoryLocation count does not match source table.'
		raiserror(@msg, 16, 1)
		
		return
	end


	-- check UserAccountLocationSnapshot
	select @countSource = count(*) from @SourceUserAccountLocation

	select @countClone = count(uals.locationobjectid)
	from UserAccountLocationSnapshot (nolock) uals
	where uals.hierarchysnapshotobjectid = @snapshotId

	-- check UserAccountLocationSnapshot counts
	if @countSource <> @countClone
	begin
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = 'UserAccountLocation count does not match source table.'
		raiserror(@msg, 16, 1)
		
		return
	end

	-- testing
	--select @countSource, @countClone


	-- action: update HiearchySnapshot status to ACTIVE
	begin try
		update hs with (rowlock)
		set hs.status = 1
		from HierarchySnapshot  hs
		where hs.objectid = @snapshotId
	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 4
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch

	-- finish transaction
	if @@TRANCOUNT > 0
		commit tran


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
