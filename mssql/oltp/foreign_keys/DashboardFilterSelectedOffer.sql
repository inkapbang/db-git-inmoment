ALTER TABLE [dbo].[DashboardFilterSelectedOffer] WITH CHECK ADD CONSTRAINT [FK_DFSOffers_DashboardFilter]
   FOREIGN KEY([dashboardFilterId]) REFERENCES [dbo].[DashboardFilter] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardFilterSelectedOffer] WITH CHECK ADD CONSTRAINT [FK_DFSOffers_Offer]
   FOREIGN KEY([offerId]) REFERENCES [dbo].[Offer] ([objectId])
   ON DELETE CASCADE

GO
