ALTER TABLE [dbo].[Campaign] WITH CHECK ADD CONSTRAINT [FK_Campaign_EmailInformation]
   FOREIGN KEY([emailInformationObjectId]) REFERENCES [dbo].[EmailInformation] ([objectId])

GO
ALTER TABLE [dbo].[Campaign] WITH CHECK ADD CONSTRAINT [FK_Campaign_IntroPrompt]
   FOREIGN KEY([introPromptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
ALTER TABLE [dbo].[Campaign] WITH CHECK ADD CONSTRAINT [FK_Campaign_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
