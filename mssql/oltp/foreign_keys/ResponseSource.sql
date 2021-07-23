ALTER TABLE [dbo].[ResponseSource] WITH CHECK ADD CONSTRAINT [FK_ResponseSource_Label]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[ResponseSource] WITH CHECK ADD CONSTRAINT [FK_ResponseSource_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[ResponseSource] WITH CHECK ADD CONSTRAINT [FK_ResponseSource_PrimaryRatingFieldObjectId]
   FOREIGN KEY([primaryRatingFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
