SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[CaesarsScoreSurveyStaging]
	@SurveyId int = 15439
	, @GatewayId int = 9998
	, @OfferId int = 9032
AS
BEGIN
	-- Created: 20161025
	-- Author: TAR
	-- Purpose: DBA-3334 - this process generates the staging table data for Caesar's Entertainment.
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- truncate staging tables
	truncate table dbo._Caesars_SurveyResponse
	truncate table dbo._Caesars_SurveyResponseAnswer

	-- override CONFIG values
	--select @SurveyId = 15439, @GatewayId = 9998, @OfferId = 9032

	-- internal vars
	declare @expectedItems int

	create table #source(SurveyResponseObjectId int, FiscalWeek varchar(50), PeriodWeek varchar(10)
	, LocationId int, LocationNumber varchar(50)
	, DataFieldObjectId int, DataFieldName varchar(50)
	, [WeightedA (10-9)] decimal(20,8), [WeightedModifiedA (10-7)] decimal(20,8)
	, [WeightedF (6-0)] decimal(20,8), [WeightedAll] decimal(20,8)
	, [UnweightedA (10-9)] int, [UnweightedModifiedA (10-7)] int
	, [UnweightedF (6-0)] int, [UnweightedAll] int
	, SurveyCount int
	, QuarterBaselineA decimal(20,8), QuarterBaselineF decimal(20,8), YearBaselineA decimal(20,8), YearBaselineF decimal(20,8)
	, Sequence int)

	-- collect set of rows to build as responses and answers (from calculation output table) as SOURCE
	insert into #source(SurveyResponseObjectId, FiscalWeek, PeriodWeek
	, LocationId, LocationNumber
	, DataFieldObjectId, DataFieldName
	, [WeightedA (10-9)], [WeightedModifiedA (10-7)] 
	, [WeightedF (6-0)], [WeightedAll] 
	, [UnweightedA (10-9)], [UnweightedModifiedA (10-7)] 
	, [UnweightedF (6-0)], [UnweightedAll] 
	, SurveyCount
	, QuarterBaselineA, QuarterBaselineF, YearBaselineA, YearBaselineF 
	, Sequence)
	select null as SurveyResponseObjectId, o.*, b.QuarterBaselineA, b.QuarterBaselineF, b.YearBaselineA, b.YearBaselineF, row_number() over (partition by o.FiscalWeek, o.LocationNumber order by o.FiscalWeek, o.LocationNumber, o.DataFieldObjectId) -1 as Sequence
	--into #source
	from _Caesars_CalculationOutput  o
		-- join calculation output to baseline details
	inner join _Caesars_CalculationBaselines b on b.fiscalweek = o.fiscalweek and b.locationnumber = o.locationnumber and b.datafieldobjectid = o.datafieldobjectid
	-- data sorted by fiscal week, locationNumber, Question
	order by o.FiscalWeek, o.LocationNumber, o.DataFieldObjectId

	--testing
	--select * from #source return

	create index idx1 on #source(PeriodWeek, LocationId, datafieldObjectId)


	-- output count of items
	select @expectedItems = count(*) from #source
	print 'Items to update: ' + cast(@expectedItems as varchar)

	-- loop controller vars
	declare @currentWeek varchar(50)
	declare @locationId bigint, @questionId bigint
	declare @currentResponseId bigint

	-- build COUNTER
	declare @items bigint
	set @items = 1

	-- build error watch
	declare @wasError bit

	-- loop: by week
	-- get initial week value
	select @currentWeek = min(PeriodWeek) from #source

	-- start week loop
	while @currentWeek is not null
	begin	
		-- loop: by location
		-- get initial locationId
		select @locationId = min(locationId) from #source where PeriodWeek = @currentWeek

		-- start location loop
		while @locationId is not null
		begin
			-- loop: by question
			select @questionId = min(datafieldobjectid) from #source where PeriodWeek = @currentWeek 
				and LocationId = @LocationId 

			-- start question loop
			while @QuestionId is not null
			begin
				set @wasError = 0

				-- build surveyResponse record
				begin try
					-- open tran
					begin tran

					insert into dbo._Caesars_SurveyResponse(
						surveyGatewayObjectId, beginDate
						, complete, surveyObjectId, dateOfService
						, [version], isRead, beginDateUTC
						, exclusionReason, locationObjectId, offerObjectId
						, NewResponseObjectId)
					-- combine details from SOURCE with CONFIG values to build response row
					select @GatewayId as surveyGatewayObjectId, cast(@currentWeek as datetime) as beginDate
					, 0 as complete, @SurveyId as surveyObjectId, cast(@currentWeek as datetime) as dateOfService
					, 1 as [version], 0 as isRead, cast(@currentWeek as datetime) as beginDateUTC
					, 0 as exclusionReason, @locationId as locationObjectId, @offerId as offerObjectId
					, null as NewResponseObjectId
					from #source
					where PeriodWeek = @currentWeek and LocationId = @locationId and datafieldobjectid = @questionId

					select @currentResponseId = SCOPE_IDENTITY()

					-- testing	
					--select @currentResponseId
				end try
				
				begin catch
					-- rollback tran
					rollback tran

					set @wasError = 1
					print 'Did not create SurveyResponse.'
					print Error_Message()
				end catch
		
				-- check error status before proceeding.
				if @wasError = 0
				begin
					-- get SurveyResponseObjectId into var
					begin try
						-- insert answers for each SurveyResponseAnswer field from SOURCE, ensuring sequence values are correctly set
						-- mapping DataFieldObjectId to column (from resource table or hardcoded?)
						-- DataFieldName
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 0 as sequence
						, [DataFieldName] as textValue
						, 0 as [version], 238205 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- WeightedA
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 1 as sequence
						, [WeightedA (10-9)] as textValue
						, 0 as [version], 238207 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- WeightedModifiedA
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 2 as sequence
						, [WeightedModifiedA (10-7)] as textValue
						, 0 as [version], 239023 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- WeightedF
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 3 as sequence
						, [WeightedF (6-0)] as textValue
						, 0 as [version], 238208 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- WeightedAll
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 4 as sequence
						, [WeightedAll] as textValue
						, 0 as [version], 238210 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- UnweightedA
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 5 as sequence
						, [UnweightedA (10-9)] as textValue
						, 0 as [version], 239024 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- UnweightedModifiedA
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 6 as sequence
						, [UnweightedModifiedA (10-7)] as textValue
						, 0 as [version], 239025 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- UnweightedF
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 7 as sequence
						, [UnweightedF (6-0)] as textValue
						, 0 as [version], 239026 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- UnweightedAll
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 8 as sequence
						, [UnweightedAll] as textValue
						, 0 as [version], 239027 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- SurveyCount
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 9 as sequence
						, [SurveyCount] as textValue
						, 0 as [version], 238212 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- QuarterBaselineA
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 10 as sequence
						, [QuarterBaselineA] as textValue
						, 0 as [version], 239697 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- QuarterBaselineF
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 11 as sequence
						, [QuarterBaselineF] as textValue
						, 0 as [version], 239698 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- YearBaselineA
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 12 as sequence
						, [YearBaselineA] as textValue
						, 0 as [version], 239700 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- YearBaselineF
						insert into _Caesars_SurveyResponseAnswer(
							surveyResponseObjectId, sequence
							, textValue
							, [version], dataFieldObjectId)
						select @currentResponseId, 13 as sequence
						, [YearBaselineF] as textValue
						, 0 as [version], 239699 as dataFieldObjectId
						from #source
						where PeriodWeek = @currentWeek and LocationId = @locationId
						and datafieldObjectId = @questionId

						-- test success output
						print 'PeriodWeek: ' + cast(@CurrentWeek as varchar) 
							+ ', LocationId: ' + cast(@LocationId as varchar) 
							+ ', QuestionId: ' + cast(@QuestionId as varchar) 
							+ ', Items processed: ' + cast(@items as varchar)
					end try

					begin catch
						-- rollback tran
						rollback tran

						print 'PeriodWeek: ' + cast(@CurrentWeek as varchar) 
							+ ', LocationId: ' + cast(@LocationId as varchar) 
							+ ', QuestionId: ' + cast(@QuestionId as varchar) 
						print Error_Message()
						set @wasError = 1
					end catch

					-- update complete
					update _Caesars_SurveyResponse
					set complete = 1
					where objectid = @currentResponseId

					if @wasError = 1
						print 'Response was not generated.'
					else
						-- commit tran
						commit tran

					-- increment COUNTER
					set @items = @items +1
				end -- end response error check
				
				-- update question loop while condition
				select @questionId = min(datafieldobjectid) from #source where PeriodWeek = @currentWeek 
					and LocationId = @LocationId and datafieldobjectid > @questionId
			end -- END question loop

			-- update location loop while condition
			select @locationId = min(locationId) from #source where PeriodWeek = @currentWeek and locationId > @locationId			
		end -- END location loop

		-- update week loop while condition
		select @currentWeek = min(periodWeek) from #source where periodWeek > @currentWeek
	end -- END week loop

	-- notify done
	print 'Done.'

	-- cleanup
	drop table #source

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
