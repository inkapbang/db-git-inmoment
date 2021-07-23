CREATE TABLE [dbo].[OrganizationAccountManagers] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_OrganizationAccountManagers] PRIMARY KEY CLUSTERED ([organizationObjectId], [userAccountObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationAccountMgrs_OrgID] ON [dbo].[OrganizationAccountManagers] ([organizationObjectId], [userAccountObjectId])

GO
