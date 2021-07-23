CREATE TABLE [dbo].[OrganizationOpsPersonnel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_OrganizationOpsPersonnel] PRIMARY KEY CLUSTERED ([organizationObjectId], [userAccountObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationOpsPersonnel_By_Organization_UserAccount] ON [dbo].[OrganizationOpsPersonnel] ([organizationObjectId], [userAccountObjectId])
CREATE NONCLUSTERED INDEX [IX_OrganizationOpsPersonnel_UserAccount] ON [dbo].[OrganizationOpsPersonnel] ([userAccountObjectId])

GO
