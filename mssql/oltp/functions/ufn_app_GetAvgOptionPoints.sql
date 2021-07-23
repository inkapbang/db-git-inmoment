SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create function [dbo].[ufn_app_GetAvgOptionPoints](@locationId int, @fieldId int, @beginDate datetime, @endDate datetime)
returns float
as
begin
	declare @averageScore float
	select @averageScore = avg(dfo.scorePoints)
	from
		DataFieldOption dfo
	inner join SurveyResponseAnswer sra
		on sra.dataFieldOptionObjectId = dfo.objectId
		and sra.dataFieldObjectId = @fieldId
	inner join SurveyResponse sr
		on sra.surveyResponseObjectId = sr.objectId
		and sr.complete = 1
		and sr.beginDate between @beginDate and @endDate
		and sr.locationObjectId = @locationId
	return @averageScore
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
