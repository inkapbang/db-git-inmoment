CREATE TABLE [dbo].[DashboardFilterSelectedSurveyGateway] (
   [dashboardFilterId] [int] NOT NULL,
   [surveyGatewayId] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardFilterSelectedSurveyGateway] PRIMARY KEY CLUSTERED ([dashboardFilterId], [surveyGatewayId])
)

CREATE NONCLUSTERED INDEX [IX_DFSSurveyGateways_DashboardFilterId] ON [dbo].[DashboardFilterSelectedSurveyGateway] ([dashboardFilterId])
CREATE NONCLUSTERED INDEX [IX_DFSSurveyGateways_SurveyGatewayId] ON [dbo].[DashboardFilterSelectedSurveyGateway] ([surveyGatewayId])

GO
