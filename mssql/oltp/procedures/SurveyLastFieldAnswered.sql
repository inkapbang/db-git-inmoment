SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure SurveyDropoutFields (@surveyObjectId int, @beginDate datetime, @endDate datetime)
as
	with Answers as (
		select sra.objectId, sra.dataFieldObjectId, rank() over(partition by sra.surveyResponseObjectId order by sra.sequence desc) as rowNumber
		from SurveyResponse sr
		inner join surveyResponseAnswer sra on sra.surveyResponseObjectId = sr.objectId
		where sr.beginDate between @beginDate and @endDate
		and sr.surveyObjectId = @surveyObjectId
	)
	select a.dataFieldObjectId objectId, (select df.name from DataField df where df.objectId = a.dataFieldObjectId) [name], count(*) [count]
	from Answers a
	where a.rowNumber = 1
	group by a.dataFieldObjectId
	order by 3 desc
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
