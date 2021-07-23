ALTER TABLE [dbo].[BeaconAction] WITH CHECK ADD CONSTRAINT [FK_BeaconAction_LaunchMessage]
   FOREIGN KEY([launchMessageObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[BeaconAction] WITH CHECK ADD CONSTRAINT [FK_BeaconAction_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[BeaconAction] WITH CHECK ADD CONSTRAINT [FK_BeaconAction_SurveyGateway]
   FOREIGN KEY([surveyGatewayObjectId]) REFERENCES [dbo].[SurveyGateway] ([objectId])

GO
ALTER TABLE [dbo].[BeaconAction] WITH CHECK ADD CONSTRAINT [FK_BeaconAction_SurveyOffer]
   FOREIGN KEY([surveyOfferCodeObjectId]) REFERENCES [dbo].[OfferCode] ([objectId])

GO
