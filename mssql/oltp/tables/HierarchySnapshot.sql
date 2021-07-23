CREATE TABLE [dbo].[HierarchySnapshot] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [hierarchyObjectId] [int] NOT NULL,
   [startDate] [datetime] NULL,
   [endDate] [datetime] NULL,
   [isCurrent] [bit] NULL,
   [createdDate] [datetime] NULL,
   [modifiedDate] [datetime] NULL,
   [createdUserAccountObjectId] [int] NULL,
   [modifiedUserAccountObjectId] [int] NULL,
   [status] [int] NOT NULL

   ,CONSTRAINT [PK_HierarchySnapshot] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [I_FK_HierarchySnapshot_Hierarchy] ON [dbo].[HierarchySnapshot] ([hierarchyObjectId])
CREATE NONCLUSTERED INDEX [I_FK_HierarchySnapshotCreatedUserObjectId_UserAccount] ON [dbo].[HierarchySnapshot] ([createdUserAccountObjectId])
CREATE NONCLUSTERED INDEX [I_FK_HierarchySnapshotModifiedUserObjectId_UserAccount] ON [dbo].[HierarchySnapshot] ([modifiedUserAccountObjectId])

GO
