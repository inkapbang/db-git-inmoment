ALTER TABLE [dbo].[OfferCode] WITH CHECK ADD CONSTRAINT [FK__OfferCode__intro__5887E2B1]
   FOREIGN KEY([introPromptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
ALTER TABLE [dbo].[OfferCode] WITH CHECK ADD CONSTRAINT [FK_OfferCode_Location]
   FOREIGN KEY([locationObjectId]) REFERENCES [dbo].[Location] ([objectId])

GO
ALTER TABLE [dbo].[OfferCode] WITH CHECK ADD CONSTRAINT [FK_OfferCode_Offer]
   FOREIGN KEY([offerObjectId]) REFERENCES [dbo].[Offer] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[OfferCode] WITH CHECK ADD CONSTRAINT [FK_OfferCode_SurveyGateway]
   FOREIGN KEY([surveyGatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])
   ON DELETE CASCADE

GO
