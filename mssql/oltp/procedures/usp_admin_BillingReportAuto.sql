SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC [dbo].[usp_admin_BillingReportAuto] 
AS
--select top 5 * from surveyresponse
	declare @endDateTime datetime
	declare @beginDateTime datetime

select @endDateTime= DATEADD(mm, DATEDIFF(mm,0,getdate()), 0)

select @beginDateTime = dateadd(mm, -3,@endDateTime)


	SELECT 	CONVERT(varchar(10), SR.beginDate, 101) + ' ' + 
		CONVERT(varchar(10), SR.beginTime, 108) AS DateAndTime,
		minutes,
		ANI,
		SR.complete AS complete
	FROM Organization O (nolock)
	INNER JOIN Location L ON L.organizationObjectId = O.objectId 
	INNER JOIN SurveyResponse SR ON SR.locationObjectId = L.objectId
	WHERE O.objectId = 195
	AND SR.beginDate between @beginDateTime and @endDateTime
	order by beginDate

--exec [dbo].[usp_admin_BillingReportAuto]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
