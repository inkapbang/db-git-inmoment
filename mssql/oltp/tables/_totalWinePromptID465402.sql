CREATE TABLE [dbo].[_totalWinePromptID465402] (
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
   [version] [int] NOT NULL,
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
   [minPostalCodeSearchRadius] [float] NOT NULL,
   [maxPostalCodeSearchRadius] [float] NOT NULL,
   [minSearchOfferCodes] [int] NOT NULL,
   [localePatternType] [int] NULL,
   [renderType] [int] NULL,
   [required] [bit] NOT NULL,
   [showRequiredMarker] [bit] NOT NULL,
   [repromptLimit] [int] NOT NULL,
   [forcedDecimalPlaces] [int] NOT NULL,
   [timePatternType] [int] NOT NULL,
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
)


GO
