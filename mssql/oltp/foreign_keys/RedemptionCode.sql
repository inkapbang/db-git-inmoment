ALTER TABLE [dbo].[RedemptionCode] WITH CHECK ADD CONSTRAINT [FK__Redemptio__offer__18784A94]
   FOREIGN KEY([offerCodeObjectId]) REFERENCES [dbo].[OfferCode] ([objectId])
   ON DELETE CASCADE

GO
