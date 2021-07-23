CREATE TABLE [databus].[_DatabusContactSettingsMatchRuleCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusContactSettingsMatchRuleCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusContactSettingsMatchRuleCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusContactSettingsMatchRuleCTCache] ([ctVersion], [ctSurrogateKey])

GO
