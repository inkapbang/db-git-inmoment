ALTER TABLE [dbo].[ScorecardScore] WITH CHECK ADD CONSTRAINT [FK_ScorecardScore_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
ALTER TABLE [dbo].[ScorecardScore] WITH CHECK ADD CONSTRAINT [FK_ScorecardScore_Score]
   FOREIGN KEY([scoreFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
