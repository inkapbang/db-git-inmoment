CREATE TABLE [dbo].[LocationCategoryType] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [description] [varchar](2000) NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [hierarchyObjectId] [int] NULL,
   [sequence] [int] NULL,
   [reviewOptIn] [bit] NULL
       DEFAULT ((0)),
   [reviewExpandChildren] [bit] NULL
       DEFAULT ((0)),
   [dataSourceType] [int] NULL,
   [externalId] [varchar](255) NULL,
   [hierarchySnapshotObjectId] [int] NULL,
   [snapshotFromLocationCategoryTypeObjectId] [int] NULL

   ,CONSTRAINT [PK_LocationCategoryType] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [I_FK_LocationCategoryType_HierarchySnapshot] ON [dbo].[LocationCategoryType] ([hierarchySnapshotObjectId])
CREATE NONCLUSTERED INDEX [IX_LocationCategoryType_by_Org] ON [dbo].[LocationCategoryType] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_LocationCategoryType_hierarchyObjectId] ON [dbo].[LocationCategoryType] ([hierarchyObjectId])

GO
