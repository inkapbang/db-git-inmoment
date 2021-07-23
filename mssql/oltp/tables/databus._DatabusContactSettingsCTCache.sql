CREATE TABLE [databus].[_DatabusContactSettingsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusContactSettingsCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusContactSettingsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusContactSettingsCTCache] ([ctVersion], [ctSurrogateKey])

GO
