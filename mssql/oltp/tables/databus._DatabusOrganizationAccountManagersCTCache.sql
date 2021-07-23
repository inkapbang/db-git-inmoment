CREATE TABLE [databus].[_DatabusOrganizationAccountManagersCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationAccountManagersCTCache_organizationObjectId_userAccountObjectId] PRIMARY KEY CLUSTERED ([organizationObjectId], [userAccountObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationAccountManagersCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationAccountManagersCTCache] ([ctVersion], [ctSurrogateKey])

GO
