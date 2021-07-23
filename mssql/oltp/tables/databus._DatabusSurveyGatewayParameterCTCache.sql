CREATE TABLE [databus].[_DatabusSurveyGatewayParameterCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSurveyGatewayParameterCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSurveyGatewayParameterCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSurveyGatewayParameterCTCache] ([ctVersion], [ctSurrogateKey])

GO
