CREATE TABLE [databus].[_DatabusOrganizationCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationCTCache] ([ctVersion], [ctSurrogateKey])

GO
