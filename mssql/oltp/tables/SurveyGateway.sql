CREATE TABLE [dbo].[SurveyGateway] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](50) NOT NULL,
   [description] [varchar](50) NULL,
   [dnis] [varchar](15) NULL,
   [failurePromptObjectId] [int] NULL,
   [audioOptionObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [gatewayType] [int] NOT NULL,
   [alias] [varchar](25) NULL,
   [defaultOfferCodeObjectId] [int] NULL,
   [organizationObjectId] [int] NULL,
   [disabledLocationSurveyObjectId] [int] NULL,
   [appType] [int] NOT NULL
       DEFAULT ((0)),
   [customUrl] [varchar](250) NULL,
   [webSurveyStyleObjectId] [int] NULL,
   [locale] [varchar](25) NULL,
   [trimOfferCodeLeadingZeros] [bit] NOT NULL,
   [campaignObjectId] [int] NULL,
   [usingDnisPool] [bit] NULL,
   [persister] [int] NULL,
   [smsKeyword] [varchar](20) NULL,
   [contestRulesConfigObjectId] [int] NULL,
   [webSurveyPresentationOption] [int] NULL,
   [webSurveyThemeObjectId] [int] NULL,
   [allowIndexing] [bit] NULL,
   [disableDigitalFingerprint] [bit] NULL,
   [attemptLocationLookup] [bit] NULL,
   [vanityUrl] [varchar](250) NULL,
   [extendSurveyTimeout] [bit] NULL,
   [forceHttpsOnVanityUrl] [bit] NULL,
   [refreshInterval] [int] NULL,
   [disableInflightSurveyCheck] [bit] NULL,
   [enableRecaptcha] [bit] NULL,
   [captchaType] [int] NULL,
   [inboundEnabled] [bit] NULL,
   [gdprEnabled] [bit] NULL,
   [disableOfferCodeFailureRateLimit] [bit] NOT NULL
      CONSTRAINT [DF_SurveyGateway_disableOfferCodeFailureRateLimit] DEFAULT ((0)),
   [wcagToggle] [bit] NULL
      CONSTRAINT [DF_SurveyGateway_wcagToggle] DEFAULT ((0)),
   [did] [bit] NULL,
   [usingDidPool] [bit] NULL,
   [externalId] [varchar](255) NULL,
   [dnisNamedPoolObjectId] [int] NULL

   ,CONSTRAINT [PK_PhoneNumber] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [_dta_index_SurveyGateway_12_1327343793__K1] ON [dbo].[SurveyGateway] ([objectId])
CREATE NONCLUSTERED INDEX [_dta_index_SurveyGateway_12_1327343793__K1_K16] ON [dbo].[SurveyGateway] ([objectId], [gatewayType])
CREATE NONCLUSTERED INDEX [_dta_index_SurveyGateway_12_1327343793__K1_K16_K4] ON [dbo].[SurveyGateway] ([objectId], [gatewayType], [dnis])
CREATE NONCLUSTERED INDEX [_dta_index_SurveyGateway_12_1327343793__K16] ON [dbo].[SurveyGateway] ([gatewayType])
CREATE NONCLUSTERED INDEX [_dta_index_SurveyGateway_12_1327343793__K16_K1] ON [dbo].[SurveyGateway] ([gatewayType], [objectId])
CREATE NONCLUSTERED INDEX [_dta_index_SurveyGateway_12_1327343793__K16_K1_K4] ON [dbo].[SurveyGateway] ([gatewayType], [objectId], [dnis])
CREATE NONCLUSTERED INDEX [_dta_index_SurveyGateway_12_1327343793__K16_K4] ON [dbo].[SurveyGateway] ([gatewayType], [dnis])
CREATE NONCLUSTERED INDEX [_dta_index_SurveyGateway_12_1327343793__K16_K4_K1] ON [dbo].[SurveyGateway] ([gatewayType], [dnis], [objectId])
CREATE NONCLUSTERED INDEX [_dta_index_SurveyGateway_12_1327343793__K4_K16] ON [dbo].[SurveyGateway] ([dnis], [gatewayType])
CREATE NONCLUSTERED INDEX [_dta_index_SurveyGateway_12_1327343793__K4_K16_K1] ON [dbo].[SurveyGateway] ([dnis], [gatewayType], [objectId])
CREATE NONCLUSTERED INDEX [IX_Gateway_By_Dnis] ON [dbo].[SurveyGateway] ([dnis])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_alias] ON [dbo].[SurveyGateway] ([alias])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_audioOptionObjectId] ON [dbo].[SurveyGateway] ([audioOptionObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_Campaign_Organization] ON [dbo].[SurveyGateway] ([campaignObjectId], [organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_ContestRulesConfig] ON [dbo].[SurveyGateway] ([contestRulesConfigObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_defaultOfferCodeObjectId] ON [dbo].[SurveyGateway] ([defaultOfferCodeObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_disabledLocationSurveyObjectId] ON [dbo].[SurveyGateway] ([disabledLocationSurveyObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_dnisNamedPoolObjectId] ON [dbo].[SurveyGateway] ([dnisNamedPoolObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_failurePromptObjectId] ON [dbo].[SurveyGateway] ([failurePromptObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_gatewayType] ON [dbo].[SurveyGateway] ([gatewayType]) INCLUDE ([dnis])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_Organization_Campaign_gatewayType] ON [dbo].[SurveyGateway] ([organizationObjectId], [campaignObjectId], [gatewayType])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_webSurveyStyleObjectId] ON [dbo].[SurveyGateway] ([webSurveyStyleObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyGateway_webSurveyThemeObjectId] ON [dbo].[SurveyGateway] ([webSurveyThemeObjectId])

GO
