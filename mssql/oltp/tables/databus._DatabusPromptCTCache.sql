CREATE TABLE [databus].[_DatabusPromptCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptCTCache] ([ctVersion], [ctSurrogateKey])

GO
