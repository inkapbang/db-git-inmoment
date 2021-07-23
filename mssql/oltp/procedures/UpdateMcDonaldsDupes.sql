SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[UpdateMcDonaldsDupes]
as
begin
	declare @responseCounter int
	declare @responseId int
	declare @responsePostalCode varchar(5)
	declare @gatewayId int
	declare @origLocationId int
	declare @origOfferCode varchar(20)
	declare @dupLocNum varchar(5)
	declare @newLocationId int
	declare @newLocationName varchar(50)
	declare @newOfferId int
	declare @newOfferCode varchar(20)
	declare @newLocationPostalCode varchar(5)
	declare @distance decimal(11, 6)
	declare @maxDistance decimal(11, 6)
	set @maxDistance = 50

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dupData]') AND type in (N'U'))
	drop table dupData

	create table dupData (
		surveyResponseObjectId int,
		offerCode varchar(20),
		responsePostalCode varchar(5),
		responseLocationObjectId int,
		nearestLocationObjectId int,
		nearestPostalCode varchar(5),
		distance decimal(11, 6)
	)

	-- Create and populate duplicate location temp table
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#dupLocs]') AND type in (N'U'))
	drop table #dupLocs

	create table #dupLocs (
		locationObjectId int not null
	)

	insert into #dupLocs (locationObjectId) (
		select 
			l.objectId 
		from 
			LocationCategoryLocation lcl with (nolock) 
			inner join Location l with (nolock) on l.objectId = lcl.locationObjectId
		where 
			lcl.locationCategoryObjectId = 14970 /* Duplicates */)

	/*
	select 
		count(*)
	from SurveyResponse sr with (nolock)
		inner join OfferCode oc with (nolock) on oc.objectId = sr.offerCodeObjectId
		inner join Location l with (nolock) on l.objectId = oc.locationObjectId
		inner join #dupLocs dl with (nolock) on l.objectId = dl.locationObjectId
	where
		sr.beginTime < dateadd(hh, -2, getdate()) /* More than 2 hours old */
	*/

	-- Create and populate response temp table
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#dupLocResponses]') AND type in (N'U'))
	drop table #dupLocResponses

	create table #dupLocResponses (
		surveyResponseObjectId int not null,
		surveyGatewayObjectId int not null,
		locationObjectId int not null,
		offerCode varchar(20) not null,
		locationNumber varchar(5) not null,
		postalCode varchar(5) null
	)

	insert into #dupLocResponses (surveyResponseObjectId, surveyGatewayObjectId, locationObjectId, offerCode, locationNumber, postalCode) (
		select 
			sr.objectId, sr.surveyGatewayObjectId, l.objectId, sr.offerCode, substring(l.locationNumber, 4, 5), substring(sra.textValue, 1, 5) 
		from 
			SurveyResponse sr with (nolock) 
			left outer join SurveyResponseAnswer sra with (nolock) on (sra.surveyResponseObjectId = sr.objectId and sra.dataFieldObjectId = 12773 /* Zip Code */)
			inner join Location l with (nolock) on l.objectId = sr.locationObjectId
			inner join #dupLocs dl with (nolock) on l.objectId = dl.locationObjectId
		where sr.beginTime < dateadd(hh, -2, getdate()) /* More than 2 hours old */
          --and sr.beginTime >= '10/04/2007 12:00 PM'
	)

	-- Find survey responses taken for duplicate locations
	declare responseCursor cursor for
		select surveyResponseObjectId, surveyGatewayObjectId, locationObjectId, offerCode, locationNumber, postalCode from #dupLocResponses order by surveyResponseObjectId

	open responseCursor
	fetch next from responseCursor into @responseId, @gatewayId, @origLocationId, @origOfferCode, @dupLocNum, @responsePostalCode
	set @responseCounter = 0
	while(@@FETCH_STATUS=0)
	begin
		set @newOfferId = null
		
		-- Find the closest location that is part of this dupe group
		select top 1
			@newLocationId = l.objectId,
			@newLocationName = l.name, 
			@newOfferId = oc.offerObjectId,
			@newOfferCode = oc.offerCode,
			@newLocationPostalCode = substring(a.postalCode, 1, 5), 
			@distance = isnull(dbo.DistanceBetweenZips(@responsePostalCode, substring(a.postalCode, 1, 5)), @maxDistance)
		from 
			LocationCategoryLocation lcl with (nolock)
			inner join Location l with (nolock) on l.objectId = lcl.locationObjectId
			inner join Address a with (nolock) on a.objectId = l.addressObjectId
			left outer join OfferCode oc with (nolock) on (l.objectId = oc.locationObjectId and oc.surveyGatewayObjectId = @gatewayId)
		where 
			lcl.locationCategoryObjectId in (
				select lc.objectId from LocationCategory lc with (nolock)
				where lc.locationCategoryTypeObjectId = 1000 /* Shared Numbers */
				and lc.name = @dupLocNum
			)
		order by isnull(dbo.DistanceBetweenZips(@responsePostalCode, substring(a.postalCode, 1, 5)), @maxDistance) asc

		/*
		print ''
		print 'ResponseId: ' + cast(@responseId as varchar)		
		print 'ResponsePostalCode: ' + isnull(@responsePostalCode, 'NULL')
		print 'GatewayId: ' + cast(@gatewayId as varchar)
		print 'OrigLocationId: ' + cast(@origLocationId as varchar)
		print 'OrigOfferCode: ' + @origOfferCode
		print 'DupLocNum: ' + @dupLocNum
		print 'NewLocationId: ' + cast(@newLocationId as varchar)
		print 'NewLocationName: ' + @newLocationName
		print 'NewOfferCodeId: ' + cast(@newOfferCodeId as varchar)
		print 'NewLocationPostalCode: ' + @newLocationPostalCode
		print 'Distance: ' + cast(@distance as varchar)
		*/
		
		insert into dupData (
			surveyResponseObjectId,
			offerCode,
			responsePostalCode,
			responseLocationObjectId,
			nearestLocationObjectId,
			nearestPostalCode,
			distance) 
		values (
			@responseId,
			@origOfferCode,
			@responsePostalCode,
			@origLocationId,
			@newLocationId,
			@newLocationPostalCode,
			@distance
		)

		if @distance >= @maxDistance
		begin
			-- No match or match was too far away, so find and move to an identified bucket
			select @newOfferId = oc.offerObjectId, @newOfferCode=oc.offerCode, @newLocationId=l.objectId from OfferCode oc with (nolock)
				inner join Location l with (nolock) on (l.objectId = oc.locationObjectId and oc.surveyGatewayObjectId = @gatewayId)
			where l.objectId = 128269 /* Unidentified Surveys Location */

			if (@@rowcount<>1) 
			begin
				set @newOfferId = null
				set @newOfferCode=null
				set @newLocationId=null
			end
		end

		if @newOfferId is not null
		begin
			-- Found a match, so assign
			print 'Changing offerId for responseId ' + cast(@responseId as varchar) + ' to ' + cast(@newOfferId as varchar) + ' (distance='+cast(@distance as varchar)+')'
			update SurveyResponse set offerObjectId = @newOfferId, locationObjectId=@newLocationId, offerCode=@newOfferCode where objectId = @responseId

			-- Create a new answer with the original offer code
			insert into SurveyResponseAnswer (surveyResponseObjectId, sequence, textValue, version, dataFieldObjectId, encrypted)
			(select @responseId, isnull(max(sequence)+1, 0), @origOfferCode, 0, 12947 /* MD Orig Offer Code Field */, 0 from SurveyResponseAnswer where surveyResponseObjectId = @responseId)
		end
		else
		begin
			DECLARE @alertMessage VARCHAR(2000)
			SET @alertMessage = 'No suitable offer code found where gatewayId=' + cast(@gatewayId as varchar) + ' and origOfferCode=' + @origOfferCode
			EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'Alert', 
			@recipients = 'dnewbold@mshare.net',
			@subject = 'Missing offer code for McDonalds Duplicate',
			@body = @alertMessage,
			@importance = 'High'
		end

		set @responseCounter = @responseCounter + 1

		fetch next from responseCursor into @responseId, @gatewayId, @origLocationId, @origOfferCode, @dupLocNum, @responsePostalCode
	end

	-- Send info
	update dupData set nearestLocationObjectId = null, nearestPostalCode = null, distance = null where distance = @maxDistance
	--select * from dupData order by surveyResponseObjectId
	--select * from dupData where distance = 0 order by surveyResponseObjectId
	--select * from dupData where distance is null order by surveyResponseObjectId
	--select * from dupData where (distance > 0 or distance is null) order by offerCode

	DECLARE @delim char(1)
	SET @delim = CHAR(9)
	DECLARE @notifyMessage VARCHAR(2000)
	SET @notifyMessage = 'The attached file contains surveys for duplicate locations that did not find an exact postal code match.  Any survey with a matching location within 50 miles was moved to that location, all others were moved to an unknown location.' + CHAR(13) + CHAR(13) + 'Total Responses Updated: ' + cast(@responseCounter as varchar)

	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		--@recipients = 'dnewbold@mshare.net',
		@recipients = 'dnewbold@mshare.net;jcrofts@mshare.net;apark@mshare.net;chortin@mshare.net;faith.gould@us.mcd.com;sue.fangmann@us.mcd.com',
		@subject = 'McDonalds Duplicates with Non-Exact Matches',
		@body = @notifyMessage,
		--@query = 'select * from dupData where (distance > 0 or distance is null) order by offerCode',
		@query = 'select * from dupData where (distance >= 50 or distance is null) order by offerCode',
		@query_result_width = 32767,
		@exclude_query_output = 1,
		@execute_query_database = 'mindshare',
		@attach_query_result_as_file = 1,
		@query_result_separator = @delim,
		@query_attachment_filename = 'MCD Failed Matches.csv',
		@importance = 'Normal'

	-- Finalize and cleanup
	print 'Updated ' + cast(@responseCounter as varchar) + ' Response(s)'
	close responseCursor
	deallocate responseCursor

	drop table #dupLocs
	drop table #dupLocResponses
	drop table dupData
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
