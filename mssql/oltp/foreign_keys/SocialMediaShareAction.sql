ALTER TABLE [dbo].[SocialMediaShareAction] WITH CHECK ADD CONSTRAINT [FK_SocialMediaShareAction_AudioOption]
   FOREIGN KEY([audioOptionObjectId]) REFERENCES [dbo].[AudioOption] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[SocialMediaShareAction] WITH CHECK ADD CONSTRAINT [FK_SocialMediaShareAction_SocialLocation]
   FOREIGN KEY([socialLocationObjectId]) REFERENCES [dbo].[SocialLocation] ([objectId])
   ON DELETE CASCADE

GO
