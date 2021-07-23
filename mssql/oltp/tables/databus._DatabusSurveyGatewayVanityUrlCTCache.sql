CREATE TABLE [databus].[_DatabusSurveyGatewayVanityUrlCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSurveyGatewayVanityUrlCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSurveyGatewayVanityUrlCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSurveyGatewayVanityUrlCTCache] ([ctVersion], [ctSurrogateKey])

GO
