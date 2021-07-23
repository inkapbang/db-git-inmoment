ALTER TABLE [dbo].[KeyDriverRankings] WITH CHECK ADD CONSTRAINT [FK_KeyDriverRankings_Location]
   FOREIGN KEY([unitObjectId]) REFERENCES [dbo].[Location] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[KeyDriverRankings] WITH CHECK ADD CONSTRAINT [FK_KeyDriverRankings_UpliftModel]
   FOREIGN KEY([upliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
