SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_Dynamite_UpdateLocations]
@organizationId int = 1419
, @certCodeDataFieldId int = 116251
, @defaultLocationId int = 2155615
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @StartDate datetime, @CurrentDate datetime
	declare @rowCount int

	-- the system searches back 90 days for items that need updating
	set @Currentdate = getDate()
	set @StartDate = DateAdd(d, -90, cast(floor(cast(@CurrentDate as float)) as datetime))

	-- testing
	--select @CurrentDate, @StartDate

	-- build table
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_dynamite_LocationUpdate') AND type = (N'U'))    DROP TABLE _dynamite_LocationUpdate
	CREATE TABLE _dynamite_LocationUpdate
			(
				SurveyResponseObjectId	bigint
				, NewLocationId			int
				, NewOfferCode			varchar(50)	
				, NewEmployeeCode		varchar(25)
			)

	-- look for responses attached to the Default Location and attempt to match with the location by CertCode values.
	-- associate the correct OfferCode as well if the new location was found
	-- in the case of multiple offerCodes, choose the code with the longest length, then lowest value
	insert into _dynamite_LocationUpdate (SurveyResponseObjectId, NewLocationId, NewOfferCode, NewEmployeeCode)
	select x.objectId as SurveyResponseObjectId, x.NewLocationId, x.NewOfferCode, NewEmployeeCode
	from (
		select sr.objectid, sr.surveygatewayobjectid, sr.offerObjectId
		, sr.offerCode
		, l.locationNumber as OldLocationId
		, ccd.locationObjectId as NewLocationId
		, oc.offerCode as NewOfferCode
		, ccd.StoreAssociate as NewEmployeeCode
		, row_number() over (partition by sr.objectid order by len(oc.offercode) desc, oc.offercode) as rnk
		from surveyresponse (nolock) sr
		inner join surveyresponseanswer (nolock) sra on sra.surveyresponseobjectid = sr.objectid and sra.datafieldobjectid = @certCodeDataFieldId
		inner join location (nolock) l on l.objectid = sr.locationobjectid and l.objectid = @defaultLocationId
		cross apply dbo.CertCodeDecode(sra.textValue, @organizationId) ccd
		inner join offercode (nolock) oc on oc.surveygatewayobjectid = sr.surveygatewayobjectid and oc.locationobjectid = ccd.locationObjectId and oc.offerobjectid = sr.offerobjectid 
		where sr.begindate >= @StartDate
		and sr.complete = 1 and sr.exclusionReason = 0
		and l.organizationobjectid = @organizationId
	) x
	where x.rnk = 1

	-- testing
	--select * from _dynamite_LocationUpdate return

	-- process updates
	declare @SurveyResponseObjectId bigint, @NewLocationId int, @NewOfferCode varchar(50), @NewEmployeeCode varchar(25)

	declare cur cursor for
	select SurveyResponseObjectId, NewLocationId, NewOfferCode, NewEmployeeCode from _dynamite_LocationUpdate

	open cur
	fetch next from cur into @SurveyResponseObjectId, @NewLocationId, @NewOfferCode, @NewEmployeeCode 

	set @rowCount = 0

	WHILE @@FETCH_Status = 0
	BEGIN

		print 'Updating: ' + isnull(cast(@SurveyResponseObjectId as varchar), '') + ' to locationId ' + isnull(cast(@NewLocationId as varchar), '')
			+ ' and offerCode ' + isnull(cast(@NewOfferCode as varchar), '') + ' and employeeCode ' + isnull(@NewEmployeeCode, '')
			+ '.'

		update surveyResponse with (rowlock)
		set offerCode = @NewOfferCode
		, locationObjectId = @NewLocationId
		, employeeCode = @NewEmployeeCode 
		where objectid = @SurveyResponseObjectId

		-- slow down cursor
		BEGIN
			WAITFOR DELAY '00:00:00.001'
		END

		-- advance cursor
		fetch next from cur into @SurveyResponseObjectId, @NewLocationId, @NewOfferCode, @NewEmployeeCode 
		set @rowCount = @rowCount +1
	END

	close cur
	deallocate cur

	print 'Processed ' + cast(@rowCount as varchar) + ' items.'
	select @rowCount as ItemsProcessed

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
