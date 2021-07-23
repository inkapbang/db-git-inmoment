CREATE TABLE [dbo].[SurveyGatewayCampaign] (
   [surveyGatewayObjectId] [int] NOT NULL,
   [campaignObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [version] [int] NULL

   ,CONSTRAINT [PK_SurveyGatewayCampaign] PRIMARY KEY CLUSTERED ([surveyGatewayObjectId], [campaignObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX_SurveyGatewayCampaign_campaignObjectId] ON [dbo].[SurveyGatewayCampaign] ([campaignObjectId])

GO
