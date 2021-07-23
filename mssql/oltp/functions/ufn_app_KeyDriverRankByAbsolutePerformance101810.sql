SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE function [dbo].[ufn_app_KeyDriverRankByAbsolutePerformance101810](@modelId int, @locationId int, @locationCategoryId int, @beginDate datetime, @endDate datetime)
returns @results table (
		driverFieldObjectId int,
		responseCount int,
		avgScore float,
		peerRank int,
		peerCount int,
		driverPeerRank int,
		driverScoreRank int
)
/*
	Ranks a specified location within its peer group by absolute performance.  Returns the score for each driver,
	plus the relative rank within the peer group.
*/
as
begin

	declare @minResponseCount int, @feedbackChannelId int
	select
		@minResponseCount = strategy.minimumResponseCount, 
		@feedbackChannelId = model.channelObjectId
	from
		KeyDriverUpliftModel model
		join KeyDriverUpliftModelRankingStrategy strategy
			on strategy.objectId = model.rankingStrategyObjectId
	where
		model.objectId = @modelId;

	declare @peers table (locationObjectId int primary key)
	insert into @peers
	select locationObjectId from dbo.ufn_app_PeerComparisonLocations(@locationCategoryId, @minResponseCount, @beginDate, @endDate,@feedbackChannelId)
	
	declare @peerCount int
	select @peerCount = count(locationObjectId) from @peers

	insert into @results
	select
		driverFieldId,
		responseCount,
		avgScore,
		peerRank,
		@peerCount,
		rank() over (order by peerRank desc) driverPeerRank,
		rank() over (order by avgScore) driverScoreRank
	from (
		select
			locationId,
			driverFieldId,
			responseCount,
			avgScore,
			rank() over (partition by driverFieldId order by avgScore desc) peerRank
		from (
			select
				r.locationId,
				r.answerFieldId driverFieldId,
				avg(dfo.scorePoints) avgScore,
				count(*) responseCount
			from
				KeyDriver driver
				left outer join (
					@peers peers
					join 
						ResponseAnswerView r
						on r.locationId = peers.locationObjectId
						and r.beginDate between @beginDate and @endDate
						and r.complete = 1
						AND r.channelId = @feedbackChannelId
						and r.exclusionReason = 0 -- 0 is no exclusion reason, i.e. no reason to be excluded from results 
					join DataFieldOption dfo
						on dfo.objectId = r.answerCategoricalId
				) on r.answerFieldId = driver.driverFieldObjectId
			where
				driver.modelObjectId = @modelId
			group by
				r.locationId, r.answerFieldId
			) Data
		) ByLocation
	where
		locationId = @locationId
	order by
		driverFieldId, peerRank
	return
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
