CREATE TABLE [databus].[_DatabusPromptChoiceCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptChoiceCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptChoiceCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptChoiceCTCache] ([ctVersion], [ctSurrogateKey])

GO
