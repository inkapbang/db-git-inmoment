CREATE TABLE [databus].[_DatabusActiveListeningQuestionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusActiveListeningQuestionCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusActiveListeningQuestionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusActiveListeningQuestionCTCache] ([ctVersion], [ctSurrogateKey])

GO
