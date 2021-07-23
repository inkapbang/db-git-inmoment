CREATE TABLE [dbo].[SurveyRequest] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [creationTime] [datetime] NOT NULL,
   [surveyGatewayObjectId] [int] NOT NULL,
   [version] [int] NULL,
   [uniqueKey] [varchar](255) NOT NULL,
   [state] [int] NOT NULL,
   [surveyResponseObjectId] [int] NULL,
   [scheduledTime] [datetime] NOT NULL,
   [expirationTime] [datetime] NOT NULL,
   [purgeTime] [datetime] NOT NULL,
   [lastAttemptTime] [datetime] NULL,
   [lastAttemptResult] [int] NOT NULL,
   [attemptCount] [int] NOT NULL,
   [contactInfo] [varchar](255) NULL,
   [contactTimeZone] [varchar](255) NULL,
   [fromContactInfo] [varchar](255) NULL,
   [failureReason] [int] NOT NULL,
   [failureMessage] [varchar](255) NULL,
   [alternateContactInfo] [varchar](255) NULL,
   [originatingSurveyRequestObjectId] [int] NULL,
   [campaignObjectId] [int] NULL,
   [surveyGatewayType] [int] NULL,
   [uniqueState] AS (case when [surveyGatewayType]=(4) AND [state]<>(3) then (1) else [objectId] end),
   [sessionId] [varchar](255) NULL,
   [surveyResponseUuid] [varchar](100) NULL,
   [uuid] [varchar](100) NULL,
   [sendReminder] [bit] NULL,
   [timezone] [varchar](50) NULL,
   [locationObjectId] [int] NULL,
   [enqueuedForReminder] [bit] NULL,
   [contactId] [varchar](44) NULL

   ,CONSTRAINT [PK_SurveyRequest] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_uniqueKey_uniqueState] UNIQUE NONCLUSTERED ([uniqueKey], [uniqueState])
)

CREATE NONCLUSTERED INDEX [IX_SurveyRequest_By_ContactInfo] ON [dbo].[SurveyRequest] ([contactInfo])
CREATE NONCLUSTERED INDEX [ix_SurveyRequest_by_failureReason] ON [dbo].[SurveyRequest] ([failureReason]) INCLUDE ([objectId], [creationTime], [surveyGatewayObjectId], [version], [uniqueKey], [state], [surveyResponseObjectId], [scheduledTime], [expirationTime], [purgeTime], [lastAttemptTime], [lastAttemptResult], [attemptCount], [contactInfo], [contactTimeZone], [fromContactInfo], [failureMessage], [alternateContactInfo], [originatingSurveyRequestObjectId], [campaignObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_by_SurveyResponse] ON [dbo].[SurveyRequest] ([surveyResponseObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_by_uniqueKey_state] ON [dbo].[SurveyRequest] ([uniqueKey], [state]) INCLUDE ([surveyGatewayObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_Campaign] ON [dbo].[SurveyRequest] ([campaignObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_failureReason_scheduledTime] ON [dbo].[SurveyRequest] ([failureReason], [scheduledTime] DESC) INCLUDE ([creationTime], [state], [version], [expirationTime])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_Gateway_CreationTime_AttemptCount] ON [dbo].[SurveyRequest] ([surveyGatewayObjectId], [creationTime], [attemptCount]) INCLUDE ([objectId])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_locationObjectId] ON [dbo].[SurveyRequest] ([locationObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_purgeTime] ON [dbo].[SurveyRequest] ([purgeTime]) INCLUDE ([state], [uniqueKey])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_sendReminder_state_scheduledTime] ON [dbo].[SurveyRequest] ([sendReminder], [state], [scheduledTime]) INCLUDE ([surveyResponseObjectId], [attemptCount], [campaignObjectId])
CREATE NONCLUSTERED INDEX [ix_surveyrequest_SendReminderState] ON [dbo].[SurveyRequest] ([sendReminder], [state]) INCLUDE ([objectId], [surveyGatewayObjectId], [surveyResponseObjectId], [lastAttemptTime], [attemptCount])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_state_SurveyGateway] ON [dbo].[SurveyRequest] ([state], [surveyGatewayObjectId]) INCLUDE ([scheduledTime])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_StateExpirationTime] ON [dbo].[SurveyRequest] ([state], [expirationTime]) INCLUDE ([objectId])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_SurveyGateway_state] ON [dbo].[SurveyRequest] ([surveyGatewayObjectId], [state], [scheduledTime])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_surveyResponseUuid] ON [dbo].[SurveyRequest] ([surveyResponseUuid]) INCLUDE ([objectId], [surveyResponseObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyRequest_uuid] ON [dbo].[SurveyRequest] ([uuid])
CREATE NONCLUSTERED INDEX [Surveyrequest_SrObjectid_UUid] ON [dbo].[SurveyRequest] ([surveyResponseObjectId], [surveyResponseUuid]) INCLUDE ([objectId])

GO
