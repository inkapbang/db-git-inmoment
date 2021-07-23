CREATE TABLE [dbo].[SsoExternalHierarchyMapping] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [externalHierarchyId] [nvarchar](100) NOT NULL,
   [webAccessCategoryTypeObjectId] [int] NULL,
   [reportDistroCategoryTypeObjectId] [int] NULL

   ,CONSTRAINT [IX_SsoExternalHierarchyMapping_UniqueExternalHierarchyId] UNIQUE NONCLUSTERED ([organizationObjectId], [externalHierarchyId])
   ,CONSTRAINT [PK_SsoExternalHierarchyMapping] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SsoExternalHierarchyMapping_LocationCategoryType_reportDistro] ON [dbo].[SsoExternalHierarchyMapping] ([reportDistroCategoryTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_SsoExternalHierarchyMapping_LocationCategoryType_webAccess] ON [dbo].[SsoExternalHierarchyMapping] ([webAccessCategoryTypeObjectId])
CREATE NONCLUSTERED INDEX [IX_SsoExternalHierarchyMapping_Organization] ON [dbo].[SsoExternalHierarchyMapping] ([organizationObjectId])

GO
