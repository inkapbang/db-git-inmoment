ALTER TABLE [dbo].[EmailInformation] WITH CHECK ADD CONSTRAINT [FK_EmailInformation_DeliveryFile]
   FOREIGN KEY([deliveryFileObjectId]) REFERENCES [dbo].[DeliveryFile] ([objectId])

GO
ALTER TABLE [dbo].[EmailInformation] WITH CHECK ADD CONSTRAINT [FK_EmailInformation_EmailAttachment]
   FOREIGN KEY([emailAttachmentObjectId]) REFERENCES [dbo].[EmailAttachment] ([objectId])

GO
ALTER TABLE [dbo].[EmailInformation] WITH CHECK ADD CONSTRAINT [FK_EmailInformation_EmailCampaign]
   FOREIGN KEY([emailCampaignObjectId]) REFERENCES [dbo].[Campaign] ([objectId])

GO
ALTER TABLE [dbo].[EmailInformation] WITH CHECK ADD CONSTRAINT [FK_EmailInformation_PromptPhrase]
   FOREIGN KEY([phraseObjectId]) REFERENCES [dbo].[Phrase] ([objectId])

GO
