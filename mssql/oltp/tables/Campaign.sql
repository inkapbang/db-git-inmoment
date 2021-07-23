CREATE TABLE [dbo].[Campaign] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [campaignType] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [emailFromAddr] [varchar](255) NULL,
   [emailFromName] [nvarchar](255) NULL,
   [emailReplyAddr] [varchar](255) NULL,
   [emailSubject] [nvarchar](1024) NULL,
   [emailBody] [nvarchar](max) NULL,
   [emailHost] [varchar](255) NULL,
   [emailHtml] [bit] NULL,
   [smtpHost] [varchar](255) NULL,
   [smtpUsername] [varchar](255) NULL,
   [smtpPassword] [varchar](255) NULL,
   [phoneMainMessageKey] [varchar](255) NULL,
   [phoneTransferMessageKey] [varchar](255) NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [phoneSubaccountId] [varchar](255) NULL,
   [provider] [int] NOT NULL,
   [phoneVoiceMailMessageKey] [varchar](255) NULL,
   [phoneVoiceMailRule] [int] NULL,
   [callWindowGroupObjectId] [int] NULL,
   [staleRequestMinutes] [int] NULL,
   [requestExpirationMinutes] [int] NOT NULL,
   [phoneMaxAttempts] [int] NULL,
   [defaultFromContactInfo] [varchar](255) NULL,
   [callInTimeZone] [int] NULL,
   [introPromptObjectId] [int] NULL,
   [accessPolicyObjectId] [int] NULL,
   [validationOfferPolicy] [int] NOT NULL,
   [weight] [int] NULL,
   [detectVoicemail] [bit] NULL,
   [reminderEmailBody] [nvarchar](max) NULL,
   [reminderSubject] [nvarchar](1024) NULL,
   [category] [nvarchar](1024) NULL,
   [reminderCategory] [nvarchar](1024) NULL,
   [maxAttempts] [int] NULL,
   [useMindshareQueue] [bit] NULL,
   [smsSid] [varchar](255) NULL,
   [smsAuthToken] [varchar](255) NULL,
   [allowSendMultipleMessages] [bit] NOT NULL
       DEFAULT ((0)),
   [emailInformationObjectId] [int] NULL,
   [doNotSendEmail] [bit] NULL,
   [useHostDomain] [tinyint] NULL

   ,CONSTRAINT [PK__Campaign__225785E0] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Campaign_campaignTypes_staleRequestMinutes] ON [dbo].[Campaign] ([campaignType], [staleRequestMinutes]) INCLUDE ([organizationObjectId], [name])
CREATE NONCLUSTERED INDEX [IX_Campaign_emailInformationObjectId] ON [dbo].[Campaign] ([emailInformationObjectId])
CREATE NONCLUSTERED INDEX [IX_Campaign_IntroPrompt] ON [dbo].[Campaign] ([introPromptObjectId])
CREATE NONCLUSTERED INDEX [IX_Campaign_Organizationclustered] ON [dbo].[Campaign] ([organizationObjectId]) INCLUDE ([staleRequestMinutes], [campaignType])
CREATE NONCLUSTERED INDEX [IX_Campaign_staleRequestMinutes_campaignType] ON [dbo].[Campaign] ([staleRequestMinutes], [campaignType]) INCLUDE ([organizationObjectId])

GO
