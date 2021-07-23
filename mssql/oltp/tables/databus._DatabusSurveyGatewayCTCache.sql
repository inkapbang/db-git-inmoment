CREATE TABLE [databus].[_DatabusSurveyGatewayCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSurveyGatewayCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSurveyGatewayCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSurveyGatewayCTCache] ([ctVersion], [ctSurrogateKey])

GO
