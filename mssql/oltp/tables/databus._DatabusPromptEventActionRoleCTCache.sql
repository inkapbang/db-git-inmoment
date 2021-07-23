CREATE TABLE [databus].[_DatabusPromptEventActionRoleCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventActionObjectId] [int] NOT NULL,
   [roleObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventActionRoleCTCache_promptEventActionObjectId_roleObjectId] PRIMARY KEY CLUSTERED ([promptEventActionObjectId], [roleObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventActionRoleCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventActionRoleCTCache] ([ctVersion], [ctSurrogateKey])

GO
