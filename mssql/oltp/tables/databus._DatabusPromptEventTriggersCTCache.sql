CREATE TABLE [databus].[_DatabusPromptEventTriggersCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggersCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggersCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggersCTCache] ([ctVersion], [ctSurrogateKey])

GO
