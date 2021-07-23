ALTER TABLE [dbo].[OfferAccessPolicy] WITH CHECK ADD CONSTRAINT [FK_OfferAccessPolicy_Offer]
   FOREIGN KEY([offerObjectId]) REFERENCES [dbo].[Offer] ([objectId])

GO
ALTER TABLE [dbo].[OfferAccessPolicy] WITH CHECK ADD CONSTRAINT [FK_OfferAccessPolicy_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
