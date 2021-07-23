CREATE TABLE [databus].[_DatabusPromptEventCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventCTCache] ([ctVersion], [ctSurrogateKey])

GO
