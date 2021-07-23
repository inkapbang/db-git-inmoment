CREATE TABLE [databus].[_DatabusPhrasePromptHierarchyMapValueCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPhrasePromptHierarchyMapValueCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPhrasePromptHierarchyMapValueCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPhrasePromptHierarchyMapValueCTCache] ([ctVersion], [ctSurrogateKey])

GO
