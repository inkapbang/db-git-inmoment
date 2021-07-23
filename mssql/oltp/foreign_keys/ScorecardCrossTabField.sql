ALTER TABLE [dbo].[ScorecardCrossTabField] WITH CHECK ADD CONSTRAINT [FK_ScorecardCrossTabField_DataField]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[ScorecardCrossTabField] WITH CHECK ADD CONSTRAINT [FK_ScorecardCrossTabField_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
