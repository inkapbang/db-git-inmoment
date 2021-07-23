CREATE TABLE [dbo].[OrganizationUserAccount] (
   [organizationObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_OrganizationUserAccount] PRIMARY KEY CLUSTERED ([organizationObjectId], [userAccountObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationUserAccount_by_AcctAndOrg] ON [dbo].[OrganizationUserAccount] ([userAccountObjectId], [organizationObjectId])

GO
