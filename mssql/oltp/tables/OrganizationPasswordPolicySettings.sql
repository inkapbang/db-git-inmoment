CREATE TABLE [dbo].[OrganizationPasswordPolicySettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [enforceCommonWordCheck] [bit] NOT NULL
       DEFAULT ((1))

   ,CONSTRAINT [PK_OrganizationPasswordPolicySettings] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_OrganizationPasswordPolicySettings_OrganizationId] UNIQUE NONCLUSTERED ([organizationObjectId])
)


GO
