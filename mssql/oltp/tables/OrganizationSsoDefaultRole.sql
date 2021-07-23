CREATE TABLE [dbo].[OrganizationSsoDefaultRole] (
   [organizationObjectId] [int] NOT NULL,
   [role] [int] NOT NULL

   ,CONSTRAINT [PK_OrganizationSsoDefaultRole] PRIMARY KEY CLUSTERED ([organizationObjectId], [role])
)


GO
