ALTER TABLE [dbo].[DashboardFilterSelectedSurveyGateway] WITH CHECK ADD CONSTRAINT [FK_DFSSurveyGateways_DashboardFilter]
   FOREIGN KEY([dashboardFilterId]) REFERENCES [dbo].[DashboardFilter] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[DashboardFilterSelectedSurveyGateway] WITH CHECK ADD CONSTRAINT [FK_DFSSurveyGateways_SurveyGateway]
   FOREIGN KEY([surveyGatewayId]) REFERENCES [dbo].[SurveyGateway] ([objectId])
   ON DELETE CASCADE

GO
