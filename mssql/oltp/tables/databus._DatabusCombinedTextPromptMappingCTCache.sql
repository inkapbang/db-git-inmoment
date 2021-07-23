CREATE TABLE [databus].[_DatabusCombinedTextPromptMappingCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusCombinedTextPromptMappingCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusCombinedTextPromptMappingCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusCombinedTextPromptMappingCTCache] ([ctVersion], [ctSurrogateKey])

GO
