CREATE TABLE [databus].[_DatabusSurveyMessageCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSurveyMessageCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSurveyMessageCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSurveyMessageCTCache] ([ctVersion], [ctSurrogateKey])

GO
