ALTER TABLE [dbo].[PageCriterionOffer] WITH CHECK ADD CONSTRAINT [FK_PageCriterionOffer_Offer]
   FOREIGN KEY([offerObjectId]) REFERENCES [dbo].[Offer] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionOffer] WITH CHECK ADD CONSTRAINT [FK_PageCriterionOffer_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
