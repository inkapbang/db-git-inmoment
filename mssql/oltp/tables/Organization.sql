CREATE TABLE [dbo].[Organization] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](100) NOT NULL,
   [addressObjectId] [int] NULL,
   [contactInfoObjectId] [int] NULL,
   [logoObjectId] [int] NULL,
   [satMin] [float] NOT NULL
       DEFAULT (0),
   [satMax] [float] NOT NULL
       DEFAULT (100),
   [dissatIndex] [float] NOT NULL
       DEFAULT (67),
   [satIndex] [float] NOT NULL
       DEFAULT (85),
   [reportingWeekBeginsOnDay] [tinyint] NOT NULL
       DEFAULT (1),
   [announcement] [varchar](max) NULL,
   [bannerObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [hidePersonalInfo] [bit] NOT NULL
       DEFAULT (0),
   [autoGenerateEmployeeCodes] [bit] NOT NULL
       DEFAULT (0),
   [salesRepObjectId] [int] NULL,
   [accountManagerExtension] [varchar](4) NULL,
   [externalCallRecordingURL] [varchar](100) NULL,
   [enabled] [bit] NOT NULL
       DEFAULT ((1)),
   [passwordPatterns] [varchar](300) NULL,
   [passwordPolicyDescription] [varchar](500) NULL,
   [passwordExpireDays] [int] NULL,
   [inboxEnabled] [bit] NOT NULL,
   [transcriptionEnabled] [bit] NOT NULL,
   [taggingEnabled] [bit] NOT NULL,
   [defaultInboxUserFilter] [int] NOT NULL,
   [inboxTaggingFilter] [int] NOT NULL,
   [messagePhoneNumberObjectId] [int] NOT NULL,
   [localeKey] [varchar](25) NULL,
   [defaultWebSurveyStyleObjectId] [int] NULL,
   [timeZone] [varchar](50) NOT NULL
       DEFAULT ('America/Denver'),
   [apiKey] [varchar](50) NOT NULL,
   [ssoHandler] [varchar](100) NULL,
   [supportPhoneNum] [nvarchar](50) NULL,
   [supportOverrideName] [nvarchar](100) NULL,
   [supportOverrideEmail] [nvarchar](100) NULL,
   [overrideSupportInfo] [int] NULL,
   [alertEmailsHaveDetail] [bit] NOT NULL,
   [maxLoginAttempts] [int] NOT NULL,
   [loginAttemptWindow] [int] NOT NULL,
   [lockoutDuration] [int] NOT NULL,
   [passwordHistoryMaxAge] [int] NULL,
   [dayWeekEndBegins] [tinyint] NULL
       DEFAULT ((7)),
   [dayWeekEndEnds] [tinyint] NULL
       DEFAULT ((1)),
   [defaultBrandObjectId] [int] NULL,
   [sslRequired] [bit] NOT NULL,
   [nonSSOLoginAllowed] [int] NULL,
   [editUserAccountAllowed] [int] NULL,
   [forgotPasswordAllowed] [int] NULL,
   [temporaryPasswordExpireHours] [int] NOT NULL,
   [hierarchyModelVersion] [int] NOT NULL
       DEFAULT ((1)),
   [passwordResetAttemptWindow] [int] NOT NULL,
   [requireAdminUnlock] [int] NOT NULL,
   [maxPasswordResets] [int] NOT NULL,
   [smsNotifications] [bit] NOT NULL
      CONSTRAINT [DF_constraint_smsNotifications] DEFAULT ((0)),
   [displayReportDigest] [bit] NOT NULL,
   [digestNotificationSubject] [varchar](max) NULL,
   [digestNotificationMessage] [varchar](max) NULL,
   [reviewOptIn] [bit] NULL,
   [reviewUpliftModelObjectId] [int] NULL,
   [reviewUnstructuredFeedbackModelObjectId] [int] NULL,
   [url] [varchar](1000) NULL,
   [description] [varchar](4000) NULL,
   [enableAnalysisApiAccess] [bit] NOT NULL,
   [defaultVociLanguageModel] [int] NULL,
   [testOrganization] [bit] NULL,
   [ssoProvisioningSupported] [bit] NULL,
   [ssoFirstNameParameter] [nvarchar](100) NULL,
   [ssoLastNameParameter] [nvarchar](100) NULL,
   [ssoEmailParameter] [nvarchar](100) NULL,
   [ssoExternalIdParameter] [nvarchar](100) NULL,
   [ssoExternalUnitIdParameter] [nvarchar](100) NULL,
   [ssoExternalHierarchyMappingParameter] [nvarchar](100) NULL,
   [ssoExternalRoleMappingParameter] [nvarchar](100) NULL,
   [reviewResponseTextObjectId] [int] NULL,
   [reviewHierarchyObjectId] [int] NULL,
   [disableLocationPages] [bit] NULL
       DEFAULT ((0)),
   [reviewEnableIndexing] [bit] NULL
       DEFAULT ((0)),
   [reviewUrl] [varchar](100) NULL,
   [defaultOovListObjectId] [int] NULL,
   [facebook] [varchar](500) NULL,
   [google] [varchar](500) NULL,
   [yelp] [varchar](500) NULL,
   [tripAdvisor] [varchar](500) NULL,
   [twitterHashtagHandle] [varchar](500) NULL,
   [disabledSurveyObjectId] [int] NULL,
   [facebookPage] [varchar](500) NULL,
   [googlePage] [varchar](500) NULL,
   [yelpPage] [varchar](500) NULL,
   [tripAdvisorPage] [varchar](500) NULL,
   [twitterHandle] [varchar](500) NULL,
   [reviewConfiguration] [int] NULL
       DEFAULT ((1)),
   [reviewRootCategoryObjectId] [int] NULL,
   [saveUncompressedAudioComments] [bit] NOT NULL
      CONSTRAINT [DF_Organization_SaveUncompressedAudioComments] DEFAULT ((0)),
   [responseBehavior] [int] NOT NULL,
   [pauseResponseWrites] [bit] NULL,
   [primaryAccountManagerObjectId] [int] NULL,
   [socialOfferObjectId] [int] NULL,
   [socialIntegrationEnabled] [bit] NOT NULL,
   [singleLogOutAllowed] [bit] NOT NULL,
   [reviewFeedbackChannelObjectId] [int] NULL,
   [sentimentPredictorType] [int] NULL,
   [offerCodePoliciesEnabled] [bit] NULL
       DEFAULT ((0)),
   [live] [bit] NULL,
   [focusCyclePeriodTypeId] [int] NULL,
   [focusCycleStartPeriodRangeId] [int] NULL,
   [focusCycleLength] [int] NULL,
   [feedbackChannelObjectId] [int] NULL,
   [platformAccess] [tinyint] NULL,
   [aggregationType] [int] NULL,
   [socialFeedbackChannelObjectId] [int] NULL,
   [socialAutoMatch] [bit] NOT NULL
       DEFAULT ((0)),
   [newLocationBehavior] [int] NOT NULL
       DEFAULT ((0)),
   [reviewGoogleAnalytics] [varchar](20) NULL,
   [middleManagementFocusAccess] [bit] NULL,
   [editableActionPlan] [bit] NULL,
   [ssoEnabled] [bit] NOT NULL
       DEFAULT ((0)),
   [focusCycleTypeId] [int] NULL,
   [focusDecimalPrecision] [int] NOT NULL
      CONSTRAINT [DF_Table_focusDecimalPrecision] DEFAULT ((0)),
   [focusSOPLimit] [int] NULL,
   [focusCustomActionLimit] [int] NULL,
   [focusTrendPeriodCount] [int] NOT NULL
      CONSTRAINT [DF_Organization_FocusTrendPeriodCount] DEFAULT ((3)),
   [thresholdType] [int] NULL,
   [analyticsOverride] [bit] NOT NULL
      CONSTRAINT [DF_Organization_analyticsOverride] DEFAULT ((1)),
   [googleAnalyticsEnabled] [bit] NOT NULL
      CONSTRAINT [DF_Organization_googleAnalyticsEnabled] DEFAULT ((0)),
   [mixpanelAnalyticsEnabled] [bit] NOT NULL
      CONSTRAINT [DF_Organization_mixpanelAnalyticsEnabled] DEFAULT ((0)),
   [focusVisibleTarget] [bit] NULL
      CONSTRAINT [DF_Organization_focusVisibleTarget] DEFAULT ((1)),
   [commentSearchEnabled] [bit] NOT NULL
      CONSTRAINT [DF_constraint_commentSearchEnabled] DEFAULT ((0)),
   [inmomentAccountId] [varchar](20) NULL,
   [defaultDataSourceType] [smallint] NULL,
   [pendolyticsEnabled] [bit] NULL
       DEFAULT ((0)),
   [incidentOverdueHours] [int] NULL,
   [announcementsPageEnabled] [bit] NULL
       DEFAULT ((0))

   ,CONSTRAINT [CHK_Organization_FocusTrendPeriodCount] CHECK NOT FOR REPLICATION ([focusTrendPeriodCount]>(1))
   ,CONSTRAINT [PK_Organization] PRIMARY KEY NONCLUSTERED ([objectId])
   ,CONSTRAINT [UK_Organization_messagePhoneNumber] UNIQUE NONCLUSTERED ([messagePhoneNumberObjectId])
)

CREATE NONCLUSTERED INDEX [IX_Organization_addressObjectId] ON [dbo].[Organization] ([addressObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_by_BannerObjectId] ON [dbo].[Organization] ([bannerObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_by_LogoObjectId] ON [dbo].[Organization] ([logoObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_by_OOVList] ON [dbo].[Organization] ([defaultOovListObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_by_RootReviewCategory] ON [dbo].[Organization] ([reviewRootCategoryObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_contactInfoObjectId] ON [dbo].[Organization] ([contactInfoObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_defaultBrandObjectId] ON [dbo].[Organization] ([defaultBrandObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_defaultWebSurveyStyleObjectId] ON [dbo].[Organization] ([defaultWebSurveyStyleObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_FeedbackChannel] ON [dbo].[Organization] ([reviewFeedbackChannelObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_FocusCycleType] ON [dbo].[Organization] ([focusCycleTypeId])
CREATE NONCLUSTERED INDEX [IX_Organization_Hierarchy_reviewHierarchy] ON [dbo].[Organization] ([reviewHierarchyObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_localeKey] ON [dbo].[Organization] ([localeKey])
CREATE NONCLUSTERED INDEX [IX_Organization_LocalizedString_reviewResponseText] ON [dbo].[Organization] ([reviewResponseTextObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_Name_ObjectId] ON [dbo].[Organization] ([name], [objectId])
CREATE CLUSTERED INDEX [IX_organization_objectid] ON [dbo].[Organization] ([objectId])
CREATE NONCLUSTERED INDEX [IX_Organization_Offer] ON [dbo].[Organization] ([socialOfferObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_PeriodRange] ON [dbo].[Organization] ([focusCycleStartPeriodRangeId])
CREATE NONCLUSTERED INDEX [IX_Organization_PeriodType] ON [dbo].[Organization] ([focusCyclePeriodTypeId])
CREATE NONCLUSTERED INDEX [IX_Organization_PlatformFeedbackChannel] ON [dbo].[Organization] ([feedbackChannelObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_reviewUnstructuredFeedbackModelObjectId] ON [dbo].[Organization] ([reviewUnstructuredFeedbackModelObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_reviewUpliftModelObjectId] ON [dbo].[Organization] ([reviewUpliftModelObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_salesRepObjectId] ON [dbo].[Organization] ([salesRepObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_SocialFeedbackChannel] ON [dbo].[Organization] ([socialFeedbackChannelObjectId])
CREATE NONCLUSTERED INDEX [IX_Organization_Survey] ON [dbo].[Organization] ([disabledSurveyObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [UK_Organization_apiKey] ON [dbo].[Organization] ([apiKey])

GO
