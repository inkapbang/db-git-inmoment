CREATE TABLE [dbo].[OrganizationTagsVersion1Mapping] (
   [organizationObjectId] [int] NOT NULL,
   [onTags1] [bit] NOT NULL

   ,CONSTRAINT [PK_OrganizationTagsVersion1Mapping] PRIMARY KEY CLUSTERED ([organizationObjectId], [onTags1])
)


GO
