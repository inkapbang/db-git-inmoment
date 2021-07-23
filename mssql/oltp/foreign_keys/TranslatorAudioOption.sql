ALTER TABLE [dbo].[TranslatorAudioOption] WITH CHECK ADD CONSTRAINT [FK__Translato__audio__385B0A41]
   FOREIGN KEY([audioOptionObjectId]) REFERENCES [dbo].[AudioOption] ([objectId])

GO
ALTER TABLE [dbo].[TranslatorAudioOption] WITH CHECK ADD CONSTRAINT [FK__Translato__userA__3766E608]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
