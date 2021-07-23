CREATE TABLE [dbo].[DashboardFilterSelectedOffer] (
   [dashboardFilterId] [int] NOT NULL,
   [offerId] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardFilterSelectedOffer] PRIMARY KEY CLUSTERED ([dashboardFilterId], [offerId])
)

CREATE NONCLUSTERED INDEX [IX_DFSOffers_DashboardFilterId] ON [dbo].[DashboardFilterSelectedOffer] ([dashboardFilterId])
CREATE NONCLUSTERED INDEX [IX_DFSOffers_OofferId] ON [dbo].[DashboardFilterSelectedOffer] ([offerId])

GO
