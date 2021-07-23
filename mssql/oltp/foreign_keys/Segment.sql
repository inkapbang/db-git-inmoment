ALTER TABLE [dbo].[Segment] WITH CHECK ADD CONSTRAINT [FK_Segment_Name_LocalizedString]
   FOREIGN KEY([nameObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Segment] WITH CHECK ADD CONSTRAINT [FK_Segment_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[Segment] WITH CHECK ADD CONSTRAINT [FK_Segment_SegmentType]
   FOREIGN KEY([segmentTypeObjectId]) REFERENCES [dbo].[SegmentType] ([objectId])

GO
