ALTER TABLE [dbo].[OrdinalFieldRecommendation] WITH CHECK ADD CONSTRAINT [FK_OrdinalFieldRecommendation_LocalizedString]
   FOREIGN KEY([localizedStringObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[OrdinalFieldRecommendation] WITH CHECK ADD CONSTRAINT [FK_OrdinalFieldRecommendation_OrdinalField]
   FOREIGN KEY([ordinalFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[OrdinalFieldRecommendation] WITH CHECK ADD CONSTRAINT [FK_OrdinalFieldRecommendation_UpliftModel]
   FOREIGN KEY([upliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
