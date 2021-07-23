CREATE TABLE [dbo].[KaseManagementSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [kaseAssignmentStrategy] [tinyint] NULL,
   [rootCauseMultipleChoiceFieldObjectId] [int] NULL,
   [preventedResolutionMultipleChoiceFieldObjectId] [int] NULL,
   [allowFollowUpSurvey] [tinyint] NOT NULL
      CONSTRAINT [DF_KaseManagementSettings_allowFollowUpSurvey] DEFAULT ((0)),
   [followUpSurveyGatewayObjectId] [int] NULL,
   [resolveEnabledForOrg] [tinyint] NOT NULL
       DEFAULT ((0)),
   [allLocationsEnabled] [tinyint] NOT NULL
       DEFAULT ((0)),
   [kaseTimerEnabled] [tinyint] NOT NULL
       DEFAULT ((1)),
   [kaseExpirationEnabled] [tinyint] NOT NULL
       DEFAULT ((0)),
   [kaseExpirationTimeInDays] [float] NULL
       DEFAULT ((0.0)),
   [hideContactDetailsEnabled] [tinyint] NOT NULL
       DEFAULT ((0)),
   [defaultDateRangePeriodObjectId] [bigint] NULL,
   [kaseCloseSurveyEnabled] [tinyint] NOT NULL
       DEFAULT ((1)),
   [kaseCloseSurveyBehaviour] [tinyint] NOT NULL
      CONSTRAINT [CK_kaseCloseSurveyBehaviour_Default] DEFAULT ((1)),
   [kaseCloseCustomSurveyGatewayObjectId] [int] NULL,
   [disableUpdateButton] [tinyint] NOT NULL
      CONSTRAINT [DF_KaseManagementSettings_disableUpdateButton] DEFAULT ((0))

   ,CONSTRAINT [CK_kaseCloseSurveyBehaviour_Range] CHECK  ([kaseCloseSurveyBehaviour]>=(0) AND [kaseCloseSurveyBehaviour]<=(2))
   ,CONSTRAINT [PK_KaseManagementSettings] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_KaseManagementSettings_organizationObjectId] ON [dbo].[KaseManagementSettings] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_KaseManagementSettings_preventedResolutionMultipleChoiceFieldObjectId] ON [dbo].[KaseManagementSettings] ([preventedResolutionMultipleChoiceFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_KaseManagementSettings_rootCauseMultipleChoiceFieldObjectId] ON [dbo].[KaseManagementSettings] ([rootCauseMultipleChoiceFieldObjectId])

GO
