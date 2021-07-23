CREATE TABLE [dbo].[OfferCode] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [offerCode] [varchar](50) NOT NULL,
   [offerObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [surveyGatewayObjectId] [int] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [introPromptObjectId] [int] NULL,
   [redemptionCodeEncoder] [int] NOT NULL,
   [generationState] [int] NULL,
   [redemptionCodeTypeFilter] [varchar](255) NULL,
   [excludeWIdentifier] [bit] NOT NULL
       DEFAULT ((0)),
   [externalId] [varchar](255) NULL

   ,CONSTRAINT [PK_OfferCode] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [U_OfferCode_Gateway_OfferCode] UNIQUE NONCLUSTERED ([surveyGatewayObjectId], [offerCode])
)

CREATE NONCLUSTERED INDEX [IX_OfferCode_by_Location] ON [dbo].[OfferCode] ([locationObjectId])
CREATE NONCLUSTERED INDEX [IX_OfferCode_by_offer] ON [dbo].[OfferCode] ([offerObjectId])
CREATE NONCLUSTERED INDEX [IX_OfferCode_By_offerCodeAndPhone] ON [dbo].[OfferCode] ([offerCode], [surveyGatewayObjectId])
CREATE NONCLUSTERED INDEX [IX_OfferCode_by_PhoneNumber] ON [dbo].[OfferCode] ([surveyGatewayObjectId])
CREATE NONCLUSTERED INDEX [IX_Offercode_GatewayIDOffercode] ON [dbo].[OfferCode] ([surveyGatewayObjectId]) INCLUDE ([objectId], [offerCode], [offerObjectId], [locationObjectId], [version], [introPromptObjectId], [redemptionCodeEncoder])
CREATE NONCLUSTERED INDEX [IX_OfferCode_introPromptObjectId] ON [dbo].[OfferCode] ([introPromptObjectId])
CREATE NONCLUSTERED INDEX [IX_OfferCode_offerCode] ON [dbo].[OfferCode] ([offerCode]) INCLUDE ([objectId], [offerObjectId], [locationObjectId], [surveyGatewayObjectId], [version], [introPromptObjectId], [redemptionCodeEncoder])

GO
