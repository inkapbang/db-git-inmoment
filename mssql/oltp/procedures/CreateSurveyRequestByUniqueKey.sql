SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[CreateSurveyRequestByUniqueKey] (@surveyGatewayObjectId INT, @purgeMinutes INT, @uniqueKey VARCHAR(255), @state INT, @objectId INT OUTPUT)

as

begin 

	begin

        DECLARE @rowcount int

        DECLARE @now datetime

		DECLARE @gatewayType int

        set @objectId = 0

        set @rowcount = 0

		set @now = GETDATE()

		if(@state <> 3) -- Check for existing new/pending/in process requests if this is a new/pending/in process request 

		begin

        	select @rowcount = count(*) from SurveyRequest where uniqueKey = @uniqueKey and not state = 3

        end



        if @rowCount = 0

        begin
			select @gatewayType = gatewayType from SurveyGateway where objectId = @surveyGatewayObjectId

			if @gatewayType = 6
			begin
				insert into SurveyRequest(creationTime, uniqueKey, surveyGatewayObjectId, version, state, lastAttemptResult, failureReason, scheduledTime, ExpirationTime, purgeTime, attemptCount, campaignObjectId, surveyGatewayType)
					select @now, @uniqueKey, @surveyGatewayObjectId, 0, @state, 0, 0, @now, DateAdd(minute, c.requestExpirationMinutes, @now), DateAdd(minute, @purgeMinutes, @now), 0, c.objectId, sg.gatewayType
					from SurveyGateway sg, SurveyGatewayCampaign sgc, Campaign c
					where sg.objectId = @surveyGatewayObjectId and sg.objectId = sgc.surveyGatewayObjectId and c.objectId=sgc.campaignObjectId and campaignType=2
			end
			else if @gatewayType = 2
			begin
				insert into SurveyRequest(creationTime, uniqueKey, surveyGatewayObjectId, version, state, lastAttemptResult, failureReason, scheduledTime, ExpirationTime, purgeTime, attemptCount, campaignObjectId, surveyGatewayType)
					select @now, @uniqueKey, @surveyGatewayObjectId, 0, @state, 0, 0, @now, DateAdd(minute, 86400, @now), DateAdd(minute, @purgeMinutes, @now), 0, null, sg.gatewayType
					from SurveyGateway sg
					where sg.objectId = @surveyGatewayObjectId
			end
			else
			begin
				insert into SurveyRequest(creationTime, uniqueKey, surveyGatewayObjectId, version, state, lastAttemptResult, failureReason, scheduledTime, ExpirationTime, purgeTime, attemptCount, campaignObjectId, surveyGatewayType)
					select @now, @uniqueKey, @surveyGatewayObjectId, 0, @state, 0, 0, @now, DateAdd(minute, c.requestExpirationMinutes, @now), DateAdd(minute, @purgeMinutes, @now), 0, c.objectId, sg.gatewayType
					from SurveyGateway sg, Campaign c
					where sg.objectId = @surveyGatewayObjectId and sg.campaignObjectId = c.objectId
			end

            select @rowcount = @@rowcount

            if @rowcount = 1 

            begin

            	select @objectId = SCOPE_IDENTITY()

            end

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
