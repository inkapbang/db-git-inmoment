ALTER TABLE [dbo].[UserAccountSegmentType] WITH CHECK ADD CONSTRAINT [FK_UserAccountSegmentType_SegmentType]
   FOREIGN KEY([segmentTypeObjectId]) REFERENCES [dbo].[SegmentType] ([objectId])

GO
ALTER TABLE [dbo].[UserAccountSegmentType] WITH CHECK ADD CONSTRAINT [FK_UserAccountSegmentType_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
