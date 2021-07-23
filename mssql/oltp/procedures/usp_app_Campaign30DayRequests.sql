SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_app_Campaign30DayRequests](
	@compaignId int, 
	@periodId int, 
	@contextDate datetime,
	@localeKey nvarchar(20) = 'en_US')
as
begin
	set nocount on

	declare @currentPeriodBegin datetime
	select
		@currentPeriodBegin = max(beginDate)
	from
		dbo.ufn_app_PeriodRanges(@periodId, @contextDate, 2, default)

	declare @totals table (beginDate datetime, totalSent int, primary key (beginDate))
	insert into @totals
		select
			d.beginDate
			,case when totalSent is null then 0 else totalSent end
		from
			dbo.ufn_app_PeriodRanges(@periodId, @contextDate, 60, @localeKey) d
		left outer join(
			select
				DATEADD(day, DATEDIFF(day, 0, SurveyRequest.scheduledTime), 0) dayGroup
				,count(*) totalSent
			from SurveyRequest
			where
				SurveyRequest.campaignObjectId = @compaignId
				and	SurveyRequest.scheduledTime >= dateadd(day, -60, @currentPeriodBegin)
			group by DATEADD(day, DATEDIFF(day, 0, SurveyRequest.scheduledTime), 0)
			) totals
			on totals.dayGroup = d.beginDate

	select
		x.beginDate
		,x.totalSent
		,AVG(cast(y.totalSent as float)) movingAverage
	from @totals x
	join @totals y
		on x.beginDate between y.beginDate and dateadd(day, +29, y.beginDate)
	where  x.beginDate between dateadd(day, -29, @currentPeriodBegin) and @currentPeriodBegin
	group by x.beginDate, x.totalSent
	order by x.beginDate
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
