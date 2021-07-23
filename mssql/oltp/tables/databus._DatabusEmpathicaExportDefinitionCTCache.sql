CREATE TABLE [databus].[_DatabusEmpathicaExportDefinitionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusEmpathicaExportDefinitionCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusEmpathicaExportDefinitionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusEmpathicaExportDefinitionCTCache] ([ctVersion], [ctSurrogateKey])

GO
