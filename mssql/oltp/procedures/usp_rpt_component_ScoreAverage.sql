SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_rpt_component_ScoreAverage]
	@locationId int,
	@dataFieldId int,
	@contextDate datetime,
	@monthsBack int,
	@periodId int = 0,  -- if ID is nonzero, use the period id specified
	@feedbackChannelId int,
	@localeKey varchar(10) = 'en_US'
as
begin
	set nocount on;

	declare @dateTable table (
		periodName nvarchar(35),
		periodRangeName nvarchar(100),
		rangeBegin datetime,
		rangeEnd datetime,
		primary key (rangeBegin, rangeEnd, periodRangeName, periodName)
	)	

	declare @ctxDate datetime
	select @ctxDate = @contextDate
	
	-- populate the date table
	if @periodId=0
		begin
			select @ctxDate = dateadd(mm, datediff(mm,0,@ctxDate), 0)
			while dateadd(mm, datediff(mm,0,@contextDate)-@monthsBack, 0)<@ctxDate
			begin
				insert into @dateTable(periodName, periodRangeName, rangeBegin, rangeEnd)
				values(N'', cast(@ctxDate as nvarchar(30)), @ctxDate, dateadd(d, -1, dateadd(m, 1, @ctxDate)))
				select @ctxDate = dateadd(mm, datediff(mm,0,@ctxDate)-1, 0)
			end
		end
	else
		begin
			declare @periodCount int
			select @periodCount = 0
			declare @decrement int
			select @decrement = case when offsetValue=-1 then 0 else -1 end from Period where objectId=@periodId 
			while @periodCount < @monthsBack
			begin
				insert into @dateTable(periodName, periodRangeName, rangeBegin, rangeEnd)
				select [periodName], [rangeLabel], [beginDate], [endDate]
					from dbo.[PeriodIntervalRanges](@periodId, @ctxDate, 'en_US')

				-- roll back the context date to one day before the beginning of the current period
				select @ctxDate = dateadd(day, @decrement, (select min(rangeBegin) from @dateTable))
				select @periodCount = @periodCount + 1
			end
		end

	select
		df.objectId [dataFieldId],
		case when df.labelObjectId is not null
			then (select cast(value as nvarchar(200)) from dbo.ufn_app_LocalizedStringTable(df.labelObjectId,@localeKey))
			else null
			end [label],
		case when df.textObjectId is not null
			then (select cast(value as nvarchar(200)) from dbo.ufn_app_LocalizedStringTable(df.textObjectId,@localeKey))
			else null
			end [text],
		d.rangeBegin [month],
		isnull(d.periodRangeName, d.rangeBegin) [period],
		avg(srs.score) [score]
	from
		@dateTable d
		inner join DataField df on df.objectId = @dataFieldId
		left outer join (
			SurveyResponse sr
			JOIN Offer o
				ON o.objectId = sr.offerObjectId
				AND channelObjectId = @feedbackChannelId
				and sr.locationObjectId = @locationId
			inner join SurveyResponseScore srs on sr.objectId = srs.surveyResponseObjectId and srs.dataFieldObjectId = @dataFieldId
		) on df.objectId = srs.dataFieldObjectId 
		and sr.beginDate between d.rangeBegin and d.rangeEnd and sr.complete=1
		and sr.exclusionReason = 0 -- 0 is no exclusion reason, i.e. no reason to be excluded from results
	group by df.objectId, d.rangeBegin, d.periodRangeName, df.labelObjectId, df.textObjectId
	order by df.objectId, d.rangeBegin, d.periodRangeName, df.labelObjectId, df.textObjectId

end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
