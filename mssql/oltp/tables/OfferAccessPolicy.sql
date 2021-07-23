CREATE TABLE [dbo].[OfferAccessPolicy] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [offerObjectId] [int] NOT NULL,
   [policyType] [int] NOT NULL,
   [timeFrameType] [int] NOT NULL,
   [limit] [int] NOT NULL,
   [promptObjectId] [int] NULL,
   [version] [int] NOT NULL,
   [limitByType] [int] NOT NULL

   ,CONSTRAINT [PK_OfferAccessPolicy] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_OfferAccessPolicy_by_offer] ON [dbo].[OfferAccessPolicy] ([offerObjectId])
CREATE NONCLUSTERED INDEX [IX_OfferAccessPolicy_promptObjectId] ON [dbo].[OfferAccessPolicy] ([promptObjectId])

GO
