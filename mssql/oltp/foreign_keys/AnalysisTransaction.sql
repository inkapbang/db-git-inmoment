ALTER TABLE [dbo].[AnalysisTransaction] WITH CHECK ADD CONSTRAINT [FK_AnalysisTransaction_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[AnalysisTransaction] WITH CHECK ADD CONSTRAINT [FK_AnalysisTransaction_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
