ALTER TABLE [dbo].[PageCriterionDeviceType] WITH CHECK ADD CONSTRAINT [FK_PageCriterionDeviceType_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
