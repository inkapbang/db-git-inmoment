CREATE TABLE [dbo].[OrganizationSecurityPolicy] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [rememberMe] [bit] NOT NULL

   ,CONSTRAINT [PK_OrganizationSecurityPolicy] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_OrganizationSecurityPolicy_OrganizationId] UNIQUE NONCLUSTERED ([organizationObjectId])
)


GO
