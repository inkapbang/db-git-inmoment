ALTER TABLE [dbo].[PageCriterionDataFieldOption] WITH CHECK ADD CONSTRAINT [FK_PageCriterionDataFieldOption_DataField]
   FOREIGN KEY([dataFieldOptionObjectId]) REFERENCES [dbo].[DataFieldOption] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionDataFieldOption] WITH CHECK ADD CONSTRAINT [FK_PageCriterionDataFieldOption_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
