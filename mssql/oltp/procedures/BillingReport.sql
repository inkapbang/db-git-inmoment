SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  PROC [dbo].[BillingReport] (@OrgObjectId INT, @beginDateTime DATETIME, @endDateTime DATETIME)
AS
	SELECT 	CONVERT(varchar(10), SR.beginDate, 101) + ' ' + 
		CONVERT(varchar(10), SR.beginTime, 108) AS DateAndTime,
		minutes,
		ANI,
		SR.complete AS complete
	FROM Organization O
	INNER JOIN Location L ON L.organizationObjectId = O.objectId  
	INNER JOIN SurveyResponse SR ON SR.locationObjectId = L.objectId
	WHERE O.objectId = @OrgObjectId
	AND SR.beginDate between @beginDateTime and @endDateTime
	order by beginDate


--exec [dbo].[BillingReport] @OrgObjectID=195,@BeginDateTime='2/01/2007',@enddatetime='11/01/2007'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
