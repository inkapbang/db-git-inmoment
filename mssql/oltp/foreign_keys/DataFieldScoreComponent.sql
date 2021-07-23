ALTER TABLE [dbo].[DataFieldScoreComponent] WITH CHECK ADD CONSTRAINT [FK__DataField__dataF__67CA2641]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[DataFieldScoreComponent] WITH CHECK ADD CONSTRAINT [FK__DataField__score__68BE4A7A]
   FOREIGN KEY([scoredDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
