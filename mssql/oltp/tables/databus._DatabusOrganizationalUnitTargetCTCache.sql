CREATE TABLE [databus].[_DatabusOrganizationalUnitTargetCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationalUnitTargetCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationalUnitTargetCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationalUnitTargetCTCache] ([ctVersion], [ctSurrogateKey])

GO
