CREATE TABLE [databus].[_DatabusOrganizationUserAccountCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationUserAccountCTCache_organizationObjectId_userAccountObjectId] PRIMARY KEY CLUSTERED ([organizationObjectId], [userAccountObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationUserAccountCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationUserAccountCTCache] ([ctVersion], [ctSurrogateKey])

GO
