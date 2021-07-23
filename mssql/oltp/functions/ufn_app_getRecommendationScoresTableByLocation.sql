SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
	CREATE FUNCTION [dbo].[ufn_app_getRecommendationScoresTableByLocation](@modelId int, @locationIds IntList READONLY, @beginDate datetime, @endDate datetime, @scoreFieldIds IntList READONLY)

	returns @Scores TABLE (
		locationObjectId int,
		surveyResponseObjectId int, 
		dataFieldObjectId int,
		score float, 
		[count] int) 

	as
	begin

		declare @aggregationType int, @thresholdType int, @threshold int, @channelId int;
		select
			@aggregationType = t.aggregationType, 
			@thresholdType = t.thresholdType, 
			@threshold = t.threshold,
			@channelId = t.channelId
		from (
			select 
				ums.aggregationType, 
				ums.thresholdType,
				CASE
					WHEN ums.thresholdType = 0 THEN 0
					ELSE ums.minimumResponseCount 
				END threshold,
				um.channelObjectId channelId
			from UpliftModel um	
				inner join UpliftModelStrategy ums on ums.objectId = um.upliftModelStrategyObjectId
			where um.objectId = @modelId
		) t

	IF (@aggregationType = 2 AND @thresholdType IN (0, 2)) --calculate scores at runtime for aggregationType=UNIT_WEIGHTED_ANSWER with thresholdType=NONE or thresholdType=ANSWER_COUNT
		BEGIN
			insert into @Scores
			select 
				sr.locationObjectId,
				sr.objectId surveyResponseObjectId,
				dfsc.dataFieldObjectId,
				avg(dfscp.points) score,
				count(sra.dataFieldObjectId) [count]
			from SurveyResponse sr
				inner join Offer o on o.objectId = sr.offerObjectId and o.channelObjectId = @channelId
				inner join @locationIds lids on lids.val = sr.locationObjectId
				inner join SurveyResponseAnswer sra on sra.surveyResponseObjectId = sr.objectId 
				inner join DataFieldScoreComponentPoints dfscp on sra.dataFieldOptionObjectId = dfscp.dataFieldOptionObjectId
				inner join DataFieldScoreComponent  dfsc on dfscp.dataFieldScoreComponentObjectId = dfsc.objectId
				inner join ufn_app_getScoreComponentCounts(@locationIds, @channelId, @beginDate, @endDate, @scoreFieldIds) scc 
					on scc.dataFieldObjectId = sra.dataFieldObjectId and scc.locationObjectId = sr.locationObjectId and dfsc.dataFieldObjectId = scc.scoreFieldId
			where scc.[count] >= @threshold			
				and sr.beginDate between @beginDate and @endDate
				and sr.complete = 1 
				and sr.exclusionReason = 0
			group by sr.locationObjectId, sr.objectId, dfsc.dataFieldObjectId
		END
	ELSE
		BEGIN
			insert into @Scores
			select 
				t.locationObjectId, 
				t.surveyResponseObjectId, 
				t.dataFieldObjectId, 
				t.score, 
				t.[count]
			from (
				select 
					sr.locationObjectId, 
					srs.surveyResponseObjectId, 
					srs.dataFieldObjectId, 
					srs.score, 
					srs.[count],
					DENSE_RANK() OVER (PARTITION BY sr.locationObjectId, srs.surveyResponseObjectId, srs.dataFieldObjectId ORDER BY srs.objectId) [rank]
				from SurveyResponseScore srs 
					inner join SurveyResponse sr on sr.objectId = srs.surveyResponseObjectId
					inner join @locationIds lids on lids.val = sr.locationObjectId
					inner join @scoreFieldIds sfids on sfids.val = srs.dataFieldObjectId
				where sr.beginDate between @beginDate and @endDate
			) t 
			where rank = 1
		END

	return
	end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
