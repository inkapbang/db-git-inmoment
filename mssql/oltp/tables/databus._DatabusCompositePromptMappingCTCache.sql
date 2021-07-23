CREATE TABLE [databus].[_DatabusCompositePromptMappingCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusCompositePromptMappingCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusCompositePromptMappingCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusCompositePromptMappingCTCache] ([ctVersion], [ctSurrogateKey])

GO
