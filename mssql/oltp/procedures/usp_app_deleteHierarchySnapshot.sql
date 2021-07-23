SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_app_deleteHierarchySnapshot]
	@targetHierarchySnapshotId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- purpose: DBA-9300 - remove a non-current hierarchy snaphot and associated records.
	-- created: 20210518
	-- author: TAR

	-- input: hierarchy snapshot id
	declare @snapshotId int
	set @snapshotId = @targetHierarchySnapshotId

	declare @msg varchar(max)

	-- action: confirm requested snapshot is in correct state
	/*** do not delete snapshot if isCurrent = 1 ***/
	-- check snapshot is in delete status
	-- check snapshot is not current
	declare @status int
	declare @isCurrent bit

	select @status = hs.status, @isCurrent = hs.isCurrent
	from hierarchySnapshot (nolock) hs
	where hs.objectid = @snapshotId

	-- check if current snapshot
	if @isCurrent = 1
	begin
		set @msg = 'Cannot Remove Current Snapshot.' 
		raiserror(@msg , 16, 1)

		return
	end

	-- check if in delete status
	if @status not in (3, 4, 5) -- DELETE status or ERROR status
	begin
		set @msg = 'Snapshot Not In Delete Status.'
		raiserror(@msg , 16, 1)

		return
	end


	/* action: lookup snapshot records */
	-- lookup LocationCategoryType for Hierarchy 
	--		provides: source LocationCategoryType records
	declare @SourceLocationCategoryType table 
		(objectId int, organizationObjectId int, name varchar(50)
		, description varchar(2000), version int, hierarchyObjectId int
		, sequence int, reviewOptIn bit, reviewExpandChildren bit
		, dataSourceType int, externalId varchar(255)
		, snapshotFromLocationCategoryTypeObjectId int
		, hierarchySnapshotObjectId int)

	-- get source LocationCategoryType records
	insert into @SourceLocationCategoryType	
	select lct.objectId, lct.organizationObjectId, lct.name
		, lct.description, lct.version, lct.hierarchyObjectId
		, lct.sequence, lct.reviewOptIn, lct.reviewExpandChildren
		, lct.dataSourceType, lct.externalId
		, lct.snapshotFromLocationCategoryTypeObjectId
		, lct.hierarchySnapshotObjectId
	from locationcategorytype (nolock) lct
	where lct.hierarchysnapshotobjectid = @snapshotId

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
	--select * from @sourceUserAccountLocationCategory return


	-- lookup OrganizationalUnit for source OrganizationalUnit records
	--		provides: source OrganizationalUnit records
	declare @SourceOrganizationalUnit table
		(objectId int, version int, locationCategoryObjectId int)
		
	insert into @SourceOrganizationalUnit
	select ou.objectId, ou.version, ou.locationCategoryObjectId
	from organizationalunit ou
	inner join @SourceLocationCategory slc on slc.objectid = ou.locationcategoryobjectid

	-- testing
	--select * from @SourceOrganizationalUnit return


	-- lookup LocationCategoryLocation for source LocationCategoryLocation records
	--		provides: source LocationCategoryLocation records
	declare @SourceLocationCategoryLocation table
		(locationCategoryObjectId int, locationObjectId int, insertOrder bigint)
		
	insert into @SourceLocationCategoryLocation
	select lcl.locationCategoryObjectId, lcl.locationObjectId, lcl.insertOrder
	from locationcategorylocation (nolock) lcl
	inner join @SourceLocationCategory slc on slc.objectid = lcl.locationcategoryobjectid

	-- testing
	--select * from @SourceLocationCategoryLocation return

	-- lookup UserAccountLocation records
	--		provides: source UserAccountLocation records
	declare @SourceUserAccountLocationSnapshot table
		(userAccountObjectId int, locationObjectId int, hierarchySnapshotObjectId int)

	insert into @SourceUserAccountLocationSnapshot
	select uals.userAccountObjectId, uals.locationObjectId, uals.hierarchySnapshotObjectId
	from UserAccountLocationSnapshot (nolock) uals
	where uals.hierarchySnapshotObjectId = @snapshotId

	-- testing
	--select * from @SourceUserAccountLocationSnapshot return


	/* action: remove snapshot and supporting records */
	-- remove UserAccountLocationSnapshot records
	--		associate back to snapshot id
	begin tran
	begin try

	delete uals
	from useraccountlocationsnapshot uals
	inner join @SourceUserAccountLocationSnapshot suals on suals.locationObjectId = uals.locationObjectId
		and suals.userAccountObjectId = uals.userAccountObjectId
		and suals.hierarchySnapshotObjectId = uals.hierarchySnapshotObjectId

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 5
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch

	if @@TRANCOUNT > 0
		commit tran


	-- remove UserAccountLocationCategory records
	begin tran
	begin try

	delete ualc
	from useraccountlocationcategory ualc
	inner join @sourceUserAccountLocationCategory sualc on sualc.locationcategoryobjectid = ualc.locationcategoryobjectid
		and sualc.useraccountobjectid = ualc.useraccountobjectid

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 5
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch

	if @@TRANCOUNT > 0
		commit tran


	-- remove LocationCategoryLocation records for snapshot
	--		associate snapshot LocationCategory to Location to match with source LocationCategory to Location
	begin tran

	begin try

	delete lcl
	from locationcategorylocation lcl
	inner join @sourcelocationcategorylocation slcl on slcl.locationcategoryobjectid = lcl.locationcategoryobjectid
		and slcl.locationobjectid = lcl.locationobjectid

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 5
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch

	if @@TRANCOUNT > 0
		commit tran

	-- remove OrganizationalUnit records for snapshot
	--		link to HierarchySnapshot and source OrganizationalUnit
	begin tran
	
	begin try
	
	delete ou
	from organizationalunit ou
	inner join @SourceOrganizationalUnit sou on sou.objectid = ou.objectid
	
	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 5
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch

	if @@TRANCOUNT > 0
		commit tran



	-- remove LocationCategory records for snapshot
	--		link to HierarchySnapshot and source LocationCategory
	begin tran

	begin try

	delete lc
	from locationcategory lc
	inner join @SourceLocationCategory slc on slc.objectid = lc.objectid

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 5
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch

	if @@TRANCOUNT > 0
		commit tran


	-- remove LocationCategoryType records for snapshot
	--		link to HierarchySnapshot and source LocationCategoryType
	begin tran

	begin try

	delete lct
	from locationcategorytype lct
	inner join @SourceLocationCategoryType slct on slct.objectid = lct.objectid and slct.hierarchysnapshotobjectid = lct.hierarchysnapshotobjectid

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 5
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch

	if @@TRANCOUNT > 0
		commit tran


	-- remove HierarchySnapshot record
	--		only remove the given snapshot
	begin tran

	begin try

	delete hs
	from hierarchySnapshot hs
	where hs.objectid = @snapshotId
		and hs.iscurrent = 0 -- not current
		and hs.status = 3 -- delete

	end try
	begin catch
		if @@TRANCOUNT > 0
			rollback tran

		update HierarchySnapshot
		set status = 5
		where objectid = @snapshotId

		select @msg = error_message()
		raiserror(@msg, 16, 1)
		
		return
	end catch

	if @@TRANCOUNT > 0
		commit tran


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
