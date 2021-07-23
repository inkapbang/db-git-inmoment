CREATE TABLE [databus].[_DatabusWebSurveyStyleCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusWebSurveyStyleCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusWebSurveyStyleCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusWebSurveyStyleCTCache] ([ctVersion], [ctSurrogateKey])

GO
