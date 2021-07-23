CREATE TABLE [dbo].[_wgOffercodeToChange17984] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [offerCode] [varchar](50) NOT NULL,
   [offerObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [surveyGatewayObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [introPromptObjectId] [int] NULL,
   [redemptionCodeEncoder] [int] NOT NULL,
   [generationState] [int] NULL,
   [redemptionCodeTypeFilter] [varchar](255) NULL,
   [excludeWIdentifier] [bit] NOT NULL,
   [externalId] [varchar](255) NULL
)


GO
