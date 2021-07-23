ALTER TABLE [dbo].[PageCriterionCampaign] WITH CHECK ADD CONSTRAINT [FK_ReportCriterionCampaign_Campaign]
   FOREIGN KEY([campaignObjectId]) REFERENCES [dbo].[Campaign] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionCampaign] WITH CHECK ADD CONSTRAINT [FK_PageCriterionCampaign_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
