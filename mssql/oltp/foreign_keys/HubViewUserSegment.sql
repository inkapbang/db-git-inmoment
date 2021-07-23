ALTER TABLE [dbo].[HubViewUserSegment] WITH CHECK ADD CONSTRAINT [FK_HubViewUserSegment_HubView]
   FOREIGN KEY([hubViewObjectId]) REFERENCES [dbo].[HubView] ([objectId])

GO
ALTER TABLE [dbo].[HubViewUserSegment] WITH CHECK ADD CONSTRAINT [FK_HubViewUserSegment_Segment]
   FOREIGN KEY([segmentObjectId]) REFERENCES [dbo].[Segment] ([objectId])

GO
