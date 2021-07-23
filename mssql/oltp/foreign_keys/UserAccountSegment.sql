ALTER TABLE [dbo].[UserAccountSegment] WITH CHECK ADD CONSTRAINT [FK_UserAccountSegment_Segment]
   FOREIGN KEY([segmentObjectId]) REFERENCES [dbo].[Segment] ([objectId])

GO
ALTER TABLE [dbo].[UserAccountSegment] WITH CHECK ADD CONSTRAINT [FK_UserAccountSegment_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
