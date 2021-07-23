ALTER TABLE [dbo].[AdvancedGatewaySecurityIdentifier] WITH CHECK ADD CONSTRAINT [FK_AdvancedGatewaySecurityIdentifier_SurveyGateway]
   FOREIGN KEY([gatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])

GO
