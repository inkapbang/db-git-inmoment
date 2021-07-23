SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[CaesarsCompositeBaselineUpdate]
AS
BEGIN
	-- CREATED: 20170110
	-- Author: ZB
	-- Modified: TAR - formed into proc for processing

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @loc int, @fld int, @fldn nvarchar(100), @qba decimal(20, 8), @qbf decimal(20, 8), @min int, @max int, @minfld int, @maxfld int, @responseid int

	-- calculate fiscal Weeks needed from data in tables
	select pr.objectid, pr.BeginDate, pr.EndDate, lsv.value as FiscalWeek
	into #FiscalWeeks
	from Period (nolock) p 
	inner join periodtype (nolock) pt on pt.objectid = p.periodtypeobjectid and pt.name = 'Caesars Fiscal Weeks'
	inner join periodRange (nolock) pr on pr.periodtypeobjectid = pt.objectid
	left outer join localizedstringvalue (nolock) lsv on lsv.localizedstringobjectid = pr.labelobjectid and lsv.localekey = 'en_us'
	where p.organizationobjectid = 1700
	and p.offsetValue = 0
	and pr.EndDate = (select min(begindate) from _Caesars_SurveyResponse_Composite)


	-- get QuarterBaselineA and QuarterBaselineF values for each location for the weeks in #FiscalWeeks
	select distinct  endDate 'BeginDate', l.objectId 'locationObjectId',  DataFieldName, c.datafieldObjectid, c.quarterBaselineA, c.quarterBaselineF 
	into #Baselines
	from #FiscalWeeks fw
	join _Caesars_CalculationBaselines c on fw.fiscalWeek = c.fiscalWeek
	join Location l on c.LocationNumber = l.locationNumber
	join _Caesars_SurveyResponse_Composite cc on l.objectId = cc.locationObjectId
	where l.organizationObjectId = 1700
	and l.enabled = 1 
	and l.name not like '%demo%'
	and DataFieldName like '%composite'
	order by c.DataFieldObjectId, locationObjectId


	select @min = MIN(locationOBjectid), @max=MAX(locationObjectId) from #Baselines

	set @loc = @min

	-- loop for each location
	while (@loc <= @max)
	begin
		select @minfld = min(datafieldobjectId), @maxfld = max(datafieldOBjectid) from #Baselines where locationObjectId = @loc

		set @fld = @minfld

		-- loop for each datafieldobject
		while (@fld <= @maxfld)
		begin
			-- get essential values
			select @fldn = DataFieldName, @qba = QuarterBaselineA, @qbf = QuarterBaselineF  from #Baselines where locationObjectId = @loc and DataFieldObjectId = @fld

			-- get responseId
			select @responseid = aa.surveyResponseObjectId
			from _Caesars_SurveyResponseAnswer_Composite aa
			join _Caesars_SurveyResponse_Composite  cc on aa.surveyResponseObjectId = cc.objectId
			join DataField df on aa.dataFieldObjectId = df.objectId and df.organizationObjectId = 1700
			where cc.locationObjectId = @loc  and aa.textValue= @fldn


			-- T E S T
			--select surveyResponseObjectId, dataFieldObjectId, textValue, @qba from _Caesars_SurveyResponseAnswer_Composite where surveyResponseObjectId = @responseid and dataFieldObjectId = 239697
			--select surveyResponseObjectId, dataFieldObjectId, textValue, @qbf from _Caesars_SurveyResponseAnswer_Composite where surveyResponseObjectId = @responseid and dataFieldObjectId = 239698

			-- update composite table values
			update _Caesars_SurveyResponseAnswer_Composite set textValue = @qba where surveyResponseObjectId = @responseid and dataFieldObjectId = 239697 -- QuarterBaselineA
			update _Caesars_SurveyResponseAnswer_Composite set textValue = @qbf  where surveyResponseObjectId = @responseid and dataFieldObjectId = 239698 -- QuarterBaselineF

			-- next loop item
			select @fld = min(datafieldobjectId)from #Baselines where locationObjectId = @loc and DataFieldObjectId > @fld
		end

		-- next loop item
		select @loc = MIN(locationOBjectid) from #Baselines where locationObjectId > @loc
	end
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
