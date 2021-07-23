CREATE TABLE [dbo].[Prompt] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](50) NOT NULL,
   [audioScript] [varchar](2000) NULL,
   [organizationObjectId] [int] NULL,
   [reportText] [varchar](2000) NULL,
   [promptType] [int] NULL,
   [reportLabel] [varchar](25) NULL,
   [minLength] [int] NULL,
   [maxLength] [int] NULL,
   [allowBargeIn] [bit] NULL,
   [version] [int] NOT NULL
      CONSTRAINT [DF__Prompt__version__475D56AF] DEFAULT (0),
   [dataFieldObjectId] [int] NULL,
   [maxRecordTime] [int] NULL,
   [confirm] [bit] NULL,
   [outputDataFieldObjectId] [int] NULL,
   [webText] [nvarchar](max) NULL,
   [destination] [varchar](400) NULL,
   [maxTime] [int] NULL,
   [allowVoiceAnswer] [bit] NULL,
   [reverseChoices] [bit] NULL,
   [datePatternType] [int] NULL,
   [minPostalCodeSearchRadius] [float] NOT NULL
       DEFAULT (0),
   [maxPostalCodeSearchRadius] [float] NOT NULL
       DEFAULT (0),
   [minSearchOfferCodes] [int] NOT NULL
       DEFAULT (0),
   [localePatternType] [int] NULL,
   [renderType] [int] NULL,
   [required] [bit] NOT NULL
       DEFAULT (1),
   [showRequiredMarker] [bit] NOT NULL
       DEFAULT (0),
   [repromptLimit] [int] NOT NULL
       DEFAULT ((2)),
   [forcedDecimalPlaces] [int] NOT NULL
       DEFAULT ((0)),
   [timePatternType] [int] NOT NULL
       DEFAULT ((0)),
   [mask] [varchar](255) NULL,
   [checksumValidated] [bit] NULL,
   [randomized] [bit] NULL,
   [checkDigitStrategy] [int] NOT NULL,
   [secondaryDataFieldObjectId] [int] NULL,
   [defaultDisabledSurveyPrompt] [bit] NULL,
   [socialMediaRendering] [int] NULL,
   [paddingOption] [int] NULL,
   [paddingCharacter] [varchar](5) NULL,
   [dateFormatter] [int] NULL,
   [timeFormatter] [int] NULL,
   [numericOnly] [bit] NULL,
   [validationType] [int] NULL,
   [replayStrategy] [int] NOT NULL,
   [sweepstakesInstantWinPromptConfigObjectId] [int] NULL,
   [hierarchyObjectId] [int] NULL,
   [promptHierarchyMapObjectId] [int] NULL,
   [ghostText] [nvarchar](2000) NULL,
   [useSweepstakes] [bit] NULL,
   [encoding] [int] NULL,
   [encodeString] [nvarchar](500) NULL,
   [includeExcludedSurveys] [bit] NULL,
   [emailInformationObjectId] [int] NULL,
   [isCurrency] [bit] NULL,
   [customDatePattern] [varchar](100) NULL,
   [instantEmailSendBehavior] [int] NULL,
   [multiBoxData] [varchar](255) NULL,
   [noThanksText] [nvarchar](255) NULL,
   [hintingType] [smallint] NULL,
   [naOptionPromptObjectId] [int] NULL,
   [externalId] [varchar](255) NULL,
   [cssIdentifier] [varchar](500) NULL,
   [minImageCount] [int] NULL,
   [maxImageCount] [int] NULL

   ,CONSTRAINT [PK_Prompt] PRIMARY KEY NONCLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Prompt_by_dataField] ON [dbo].[Prompt] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [ix_Prompt_by_Orgid_Includeeverything] ON [dbo].[Prompt] ([organizationObjectId]) INCLUDE ([objectId], [name], [audioScript], [promptType], [minLength], [maxLength], [allowBargeIn], [version], [dataFieldObjectId], [maxRecordTime], [confirm], [outputDataFieldObjectId], [webText], [destination], [allowVoiceAnswer], [encoding], [reverseChoices], [datePatternType], [minPostalCodeSearchRadius], [maxPostalCodeSearchRadius], [minSearchOfferCodes], [localePatternType], [renderType], [required], [showRequiredMarker], [repromptLimit], [forcedDecimalPlaces], [timePatternType], [mask], [checksumValidated], [randomized])
CREATE NONCLUSTERED INDEX [IX_Prompt_by_outputDataFieldObjectId] ON [dbo].[Prompt] ([outputDataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_PROMPT_BY_PROMPT_TYPE] ON [dbo].[Prompt] ([promptType])
CREATE NONCLUSTERED INDEX [IX_Prompt_DataField_secondaryField] ON [dbo].[Prompt] ([secondaryDataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_Prompt_emailInformationObjectId] ON [dbo].[Prompt] ([emailInformationObjectId])
CREATE NONCLUSTERED INDEX [IX_Prompt_hierarchyObjectId] ON [dbo].[Prompt] ([hierarchyObjectId])
CREATE NONCLUSTERED INDEX [IX_Prompt_naOptionPromptObjectId] ON [dbo].[Prompt] ([naOptionPromptObjectId])
CREATE NONCLUSTERED INDEX [IX_Prompt_Organization] ON [dbo].[Prompt] ([organizationObjectId], [objectId]) INCLUDE ([name])
CREATE NONCLUSTERED INDEX [IX_Prompt_promptHierarchyMapObjectId] ON [dbo].[Prompt] ([promptHierarchyMapObjectId])
CREATE NONCLUSTERED INDEX [IX_Prompt_sweepstakesInstantWinPromptConfigObjectId] ON [dbo].[Prompt] ([sweepstakesInstantWinPromptConfigObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [UK_Prompt_externalId_organizationId] ON [dbo].[Prompt] ([externalId], [organizationObjectId]) WHERE ([externalId] IS NOT NULL)

GO
