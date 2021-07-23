ALTER TABLE [dbo].[SegmentType] WITH CHECK ADD CONSTRAINT [FK_SegmentType_Name_LocalizedString]
   FOREIGN KEY([nameObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[SegmentType] WITH CHECK ADD CONSTRAINT [FK_SegmentType_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
