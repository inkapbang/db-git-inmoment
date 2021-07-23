CREATE TABLE [dbo].[OfferCodePolicyEntry] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](100) NOT NULL,
   [surveyGatewayObjectId] [int] NOT NULL,
   [offerObjectId] [int] NOT NULL,
   [offerCodePolicyObjectId] [int] NOT NULL,
   [redemptionCodeEncoder] [int] NULL,
   [version] [int] NOT NULL,
   [introPromptObjectId] [int] NULL,
   [extensionType] [int] NOT NULL,
   [extension] [varchar](5) NULL,
   [codeReuseBehavior] [int] NOT NULL,
   [codeField] [int] NOT NULL,
   [redemptionCodeTypeFilter] [varchar](255) NULL,
   [codePadType] [int] NOT NULL
      CONSTRAINT [DF_codePadType] DEFAULT ((0)),
   [codePadChar] [varchar](1) NOT NULL
      CONSTRAINT [DF_codePadChar] DEFAULT ((0)),
   [padToPosition] [int] NOT NULL
      CONSTRAINT [DF_padToPosition] DEFAULT ((4)),
   [excludeWIdentifier] [bit] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_OfferCodePolicyEntry] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_OfferCodePolicyEntry_Gateway_OfferCodePolicy_ExtensionType_Extension_CodePadType_CodePadChar_PadToPosition] UNIQUE NONCLUSTERED ([surveyGatewayObjectId], [offerCodePolicyObjectId], [extensionType], [extension], [codePadType], [codePadChar], [padToPosition])
   ,CONSTRAINT [UK_OfferCodePolicyEntry_Name_OfferCodePolicy] UNIQUE NONCLUSTERED ([name], [offerCodePolicyObjectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_OfferCodePolicyEntry_Gateway_OfferCodePolicy_ExtensionType_Extension] ON [dbo].[OfferCodePolicyEntry] ([surveyGatewayObjectId], [offerCodePolicyObjectId], [extensionType], [extension]) WHERE ([codePadType]=(0))
CREATE NONCLUSTERED INDEX [IX_OfferCodePolicyEntry_Offer] ON [dbo].[OfferCodePolicyEntry] ([offerObjectId])
CREATE NONCLUSTERED INDEX [IX_OfferCodePolicyEntry_prompt] ON [dbo].[OfferCodePolicyEntry] ([introPromptObjectId])

GO
