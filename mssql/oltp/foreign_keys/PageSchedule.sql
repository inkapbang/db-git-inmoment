ALTER TABLE [dbo].[PageSchedule] WITH CHECK ADD CONSTRAINT [FK_PageSchedule_DeliveryTitle_LocalizedString]
   FOREIGN KEY([deliveryTitleObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[PageSchedule] WITH CHECK ADD CONSTRAINT [FK_PageSchedule_FtpProfile]
   FOREIGN KEY([ftpProfileObjectId]) REFERENCES [dbo].[FtpProfile] ([objectId])

GO
ALTER TABLE [dbo].[PageSchedule] WITH CHECK ADD CONSTRAINT [FK_PageSchedule_Instructions_LocalizedString]
   FOREIGN KEY([instructionsObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[PageSchedule] WITH CHECK ADD CONSTRAINT [FK_PageSchedule_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
ALTER TABLE [dbo].[PageSchedule] WITH CHECK ADD CONSTRAINT [FK_PageSchedule_Period]
   FOREIGN KEY([periodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[PageSchedule] WITH CHECK ADD CONSTRAINT [FK_PageSchedule_Title_LocalizedString]
   FOREIGN KEY([titleObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
