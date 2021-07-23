ALTER TABLE [dbo].[DataFieldOptionRecommendation] WITH CHECK ADD CONSTRAINT [FK_DataFieldOptionRecommendation_DataFieldOption]
   FOREIGN KEY([dataFieldOptionObjectId]) REFERENCES [dbo].[DataFieldOption] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldOptionRecommendation] WITH CHECK ADD CONSTRAINT [FK_DataFieldOptionRecommendation_LocalizedString]
   FOREIGN KEY([localizedStringObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldOptionRecommendation] WITH CHECK ADD CONSTRAINT [FK_DataFieldOptionRecommendation_UpliftModel]
   FOREIGN KEY([upliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
