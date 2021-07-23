CREATE TABLE [dbo].[PageCriterionOffer] (
   [pageCriterionObjectId] [int] NOT NULL,
   [offerObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionOffer] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [offerObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionOffer_offerObjectId] ON [dbo].[PageCriterionOffer] ([offerObjectId])

GO
