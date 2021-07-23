SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
	CREATE FUNCTION [dbo].[ufn_app_getRatingCounts](@locationIds IntList READONLY, @channelId int, @beginDate datetime, @endDate datetime)

	returns @RatingCounts TABLE (
			locationObjectId int,
			dataFieldObjectId int,
			[count] int)
	as
	begin
		insert into @RatingCounts
		select 
			sr.locationObjectId,
			sra.dataFieldObjectId,
			count(*) [count]
		from SurveyResponse sr
			inner join Offer o on o.objectId = sr.offerObjectId and o.channelObjectId = @channelId
			inner join @locationIds lids on lids.val = sr.locationObjectId
			inner join SurveyResponseAnswer sra on sra.surveyResponseObjectId = sr.objectId 
			inner join DataFieldOption dfo on dfo.objectId = sra.dataFieldOptionObjectId
		where sr.beginDate between @beginDate and @endDate
			and sr.complete = 1 
			and sr.exclusionReason = 0
		group by sr.locationObjectId, sra.dataFieldObjectId
	return
	end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
