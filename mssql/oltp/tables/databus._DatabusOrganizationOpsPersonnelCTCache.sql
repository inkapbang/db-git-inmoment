CREATE TABLE [databus].[_DatabusOrganizationOpsPersonnelCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationOpsPersonnelCTCache_organizationObjectId_userAccountObjectId] PRIMARY KEY CLUSTERED ([organizationObjectId], [userAccountObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationOpsPersonnelCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationOpsPersonnelCTCache] ([ctVersion], [ctSurrogateKey])

GO
