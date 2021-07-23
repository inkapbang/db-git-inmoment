ALTER TABLE [dbo].[ResponseSegment] WITH CHECK ADD CONSTRAINT [FK_ResponseSegment_Segment]
   FOREIGN KEY([segmentObjectId]) REFERENCES [dbo].[Segment] ([objectId])

GO
