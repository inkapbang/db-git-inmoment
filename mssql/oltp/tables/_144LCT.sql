CREATE TABLE [dbo].[_144LCT] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [description] [varchar](2000) NULL,
   [version] [int] NOT NULL,
   [hierarchyObjectId] [int] NULL,
   [sequence] [int] NULL,
   [reviewOptIn] [bit] NULL,
   [reviewExpandChildren] [bit] NULL,
   [dataSourceType] [int] NULL,
   [externalId] [varchar](255) NULL,
   [hierarchySnapshotObjectId] [int] NULL,
   [snapshotFromLocationCategoryTypeObjectId] [int] NULL
)


GO
