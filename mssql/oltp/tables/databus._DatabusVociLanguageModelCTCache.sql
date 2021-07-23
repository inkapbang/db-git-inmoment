CREATE TABLE [databus].[_DatabusVociLanguageModelCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusVociLanguageModelCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusVociLanguageModelCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusVociLanguageModelCTCache] ([ctVersion], [ctSurrogateKey])

GO
