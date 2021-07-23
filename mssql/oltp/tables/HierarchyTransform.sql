CREATE TABLE [dbo].[HierarchyTransform] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [organizationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_HierarchyTransform] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HierarchyTransform_OrganizationId] ON [dbo].[HierarchyTransform] ([organizationObjectId])

GO
