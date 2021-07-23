SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[CreateSurveyRequestByDnis] (@surveyGatewayObjectId INT, @purgeMinutes INT, @state INT, @objectId INT OUTPUT)
as
begin
	begin
		DECLARE @rowcount int
		DECLARE @now datetime
		DECLARE @expireMinutes int
        
        set @objectId = 0
        set @rowcount = 0
		set @now = GETDATE()
		
		insert into SurveyRequest(creationTime, uniqueKey, surveyGatewayObjectId, version, state, lastAttemptResult, failureReason, scheduledTime, ExpirationTime, purgeTime, attemptCount, surveyGatewayType)
          select top 1 @now, sg.dnis, @surveyGatewayObjectId, 0, @state, 0, 0, @now, DateAdd(minute, 3, @now), DateAdd(minute, @purgeMinutes, @now), 0, sg.gatewayType
           from SurveyGateway sg
           where sg.gatewayType = 3 
            and sg.dnis not in 
             (select sr.uniqueKey 
                from SurveyRequest sr inner join 
                     SurveyGateway sg on sr.surveyGatewayObjectId = sg.objectId
               where sg.gatewayType = (select gatewayType from SurveyGateway where objectId = @surveyGatewayObjectId)
               and sr.state <> 3) 
          order by RAND(CHECKSUM(NEWID()))

		select @rowcount = @@rowcount
		if @rowcount <> 1 
			begin
				set @objectId = 0
			end
		else 
			begin
				select @objectId = SCOPE_IDENTITY()
			end
	end
	return @objectId
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
