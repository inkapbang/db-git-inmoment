SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_app_ClearDeliveryRun](
      @beginDate datetime,
      @endDate datetime)
as
BEGIN
    DELETE FROM PageLogEntryUserAccount where pageLogEntryObjectId in (
      SELECT objectId FROM PageLogEntry where creationDateTime between @beginDate and @endDate
    )

	DELETE FROM PageLogEntryOrganizationalUnit
	WHERE objectId in (
		SELECT PLEOU.objectId
		FROM PageLogEntryOrganizationalUnit PLEOU 
			join PageLogEntry PLE
				ON PLEOU.pageLogEntryObjectId = PLE.objectId
		WHERE PLE.creationDateTime between @beginDate and @endDate)

    DELETE FROM PageLogEntry where creationDateTime between @beginDate and @endDate
END

--exec [dbo].[usp_app_ClearReportRun] '10/9/2008','10/17/2008'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
