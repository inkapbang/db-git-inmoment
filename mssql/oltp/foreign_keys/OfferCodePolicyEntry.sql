ALTER TABLE [dbo].[OfferCodePolicyEntry] WITH CHECK ADD CONSTRAINT [FK_OfferCodePolicyEntry_prompt]
   FOREIGN KEY([introPromptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
ALTER TABLE [dbo].[OfferCodePolicyEntry] WITH CHECK ADD CONSTRAINT [FK_OfferCodePolicyEntry_offer]
   FOREIGN KEY([offerObjectId]) REFERENCES [dbo].[Offer] ([objectId])

GO
ALTER TABLE [dbo].[OfferCodePolicyEntry] WITH CHECK ADD CONSTRAINT [FK_OfferCodePolicyEntry_gateway]
   FOREIGN KEY([surveyGatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])

GO
