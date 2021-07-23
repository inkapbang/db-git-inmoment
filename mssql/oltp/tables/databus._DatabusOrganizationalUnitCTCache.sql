CREATE TABLE [databus].[_DatabusOrganizationalUnitCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationalUnitCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationalUnitCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationalUnitCTCache] ([ctVersion], [ctSurrogateKey])

GO
