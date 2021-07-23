CREATE TABLE [databus].[_DatabusOrganizationDateTypeConfigCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationDateTypeConfigCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationDateTypeConfigCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationDateTypeConfigCTCache] ([ctVersion], [ctSurrogateKey])

GO
