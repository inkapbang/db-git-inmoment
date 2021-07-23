CREATE TABLE [databus].[_DatabusSurveyGatewayCampaignCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [surveyGatewayObjectId] [int] NOT NULL,
   [campaignObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSurveyGatewayCampaignCTCache_surveyGatewayObjectId_campaignObjectId_sequence] PRIMARY KEY CLUSTERED ([surveyGatewayObjectId], [campaignObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSurveyGatewayCampaignCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSurveyGatewayCampaignCTCache] ([ctVersion], [ctSurrogateKey])

GO
