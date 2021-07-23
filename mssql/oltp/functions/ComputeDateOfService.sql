SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE function ComputeDateOfService(@responseId int)
returns datetime
as
begin
	declare @dos datetime;
	
	with EventOptionCTE as (
	select distinct
		event.actionDateOfServicetype,
		trig.dataFieldOptionObjectId,
		(case actionDateOfServiceType when 1 then 0 when 2 then -1 end) dateOffset
	from promptevent event
		inner join prompteventtrigger trig on trig.promptEventObjectId = event.objectId
	where actionDateOfServiceType is not null
	)

	-- coalesce it because it may already be set to something else
	select @dos = coalesce(sr.dateOfService, dateadd(day, EventOptionCTE.dateOffset, sr.beginDate)) 
	from SurveyResponse sr
		inner join SurveyResponseAnswer sra on sra.surveyResponseObjectId = sr.objectId
		inner join EventOptionCTE on EventOptionCTE.dataFieldOptionObjectId = sra.dataFieldOptionObjectId
	where sr.objectId = @responseId
	
	return @dos
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
