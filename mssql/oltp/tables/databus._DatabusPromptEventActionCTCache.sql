CREATE TABLE [databus].[_DatabusPromptEventActionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventActionCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventActionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventActionCTCache] ([ctVersion], [ctSurrogateKey])

GO
