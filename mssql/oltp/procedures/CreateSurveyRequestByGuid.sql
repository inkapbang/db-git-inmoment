SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[CreateSurveyRequestByGuid] (@surveyGatewayObjectId INT, @purgeMinutes INT, @state INT, @objectId INT OUTPUT)
as
begin
	declare @uniqueKey varchar(255)
	set @uniqueKey = NEWID()
	exec CreateSurveyRequestByUniqueKey @surveyGatewayObjectId, @purgeMinutes, @uniqueKey, @state, @objectId OUTPUT
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
