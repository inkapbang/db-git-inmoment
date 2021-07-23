SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
	CREATE FUNCTION [dbo].[ufn_app_getScoreComponentCounts](@locationIds IntList READONLY, @channelId int, @beginDate datetime, @endDate datetime, @scoreFieldIds IntList READONLY)

	returns @ScoreComponentCounts TABLE (
			locationObjectId int,
			scorefieldId int,
			dataFieldObjectId int,
			[count] int)
	as
	begin
		insert into @ScoreComponentCounts
		select 
			sr.locationObjectId,
			sfids.val scoreFieldId,
			sra.dataFieldObjectId,
			count(*) [count]
		from SurveyResponse sr
			inner join Offer o on o.objectId = sr.offerObjectId and o.channelObjectId = @channelId
			inner join @locationIds lids on lids.val = sr.locationObjectId
			inner join SurveyResponseAnswer sra on sra.surveyResponseObjectId = sr.objectId 
			inner join DataFieldScoreComponentPoints dfscp on sra.dataFieldOptionObjectId = dfscp.dataFieldOptionObjectId
			inner join DataFieldScoreComponent dfsc on dfscp.dataFieldScoreComponentObjectId = dfsc.objectId
			inner join @scoreFieldIds sfids on sfids.val = dfsc.dataFieldObjectId
		where sr.beginDate between @beginDate and @endDate
			and sr.complete = 1 
			and sr.exclusionReason = 0
		group by sr.locationObjectId, sfids.val, sra.dataFieldObjectId 
	return
	end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
