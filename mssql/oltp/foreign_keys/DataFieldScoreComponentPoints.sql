ALTER TABLE [dbo].[DataFieldScoreComponentPoints] WITH CHECK ADD CONSTRAINT [FK_DataFieldScoreComponentPoints_DataFieldOption]
   FOREIGN KEY([dataFieldOptionObjectId]) REFERENCES [dbo].[DataFieldOption] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldScoreComponentPoints] WITH CHECK ADD CONSTRAINT [FK_DataFieldScoreComponentPoints_DataFieldScoreComponent]
   FOREIGN KEY([dataFieldScoreComponentObjectId]) REFERENCES [dbo].[DataFieldScoreComponent] ([objectId])

GO
