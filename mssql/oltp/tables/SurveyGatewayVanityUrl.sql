CREATE TABLE [dbo].[SurveyGatewayVanityUrl] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [surveyGatewayObjectId] [int] NOT NULL,
   [url] [nvarchar](512) NULL,
   [certExists] [bit] NULL

   ,CONSTRAINT [PK_SurveyGatewayVanityUrl] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SurveyGatewayVanityUrl_surveyGatewayObjectId] ON [dbo].[SurveyGatewayVanityUrl] ([surveyGatewayObjectId])
CREATE NONCLUSTERED INDEX [IX_SurveyGatewayVanityUrl_url] ON [dbo].[SurveyGatewayVanityUrl] ([url])

GO
