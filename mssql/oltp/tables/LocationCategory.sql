CREATE TABLE [dbo].[LocationCategory] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [nvarchar](100) NULL,
   [organizationObjectId] [int] NOT NULL,
   [parentObjectId] [int] NULL,
   [depth] [tinyint] NOT NULL,
   [lineage] [varchar](255) NULL,
   [LocationCategoryTypeObjectId] [int] NULL,
   [lineageSort] AS ([lineage] + convert(varchar(10),[objectId])),
   [version] [int] NOT NULL
       DEFAULT (0),
   [timeZone] [varchar](50) NOT NULL
       DEFAULT ('America/Denver'),
   [externalId] [varchar](255) NULL,
   [rootObjectId] [int] NULL,
   [leftExtent] [int] NULL,
   [rightExtent] [int] NULL,
   [reviewOptIn] [bit] NULL,
   [reviewAggregate] [bit] NULL,
   [reviewUrl] [varchar](100) NULL,
   [brandObjectId] [int] NOT NULL,
   [snapshotFromLocationCategoryObjectId] [int] NULL

   ,CONSTRAINT [PK_LocationCategory] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_LocationCategory_brandObjectId] ON [dbo].[LocationCategory] ([brandObjectId])
CREATE NONCLUSTERED INDEX [IX_LocationCategory_by_category_type] ON [dbo].[LocationCategory] ([LocationCategoryTypeObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [IX_LocationCategory_by_LocationCategoryType_id] ON [dbo].[LocationCategory] ([LocationCategoryTypeObjectId], [objectId]) INCLUDE ([name])
CREATE NONCLUSTERED INDEX [IX_LocationCategory_by_Organization] ON [dbo].[LocationCategory] ([organizationObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [IX_LocationCategory_by_Parent_ID] ON [dbo].[LocationCategory] ([parentObjectId], [LocationCategoryTypeObjectId], [objectId]) INCLUDE ([name], [organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_LocationCategory_Lineage] ON [dbo].[LocationCategory] ([lineage]) INCLUDE ([objectId], [name], [organizationObjectId], [parentObjectId], [depth], [LocationCategoryTypeObjectId], [version], [externalId])
CREATE NONCLUSTERED INDEX [IX_Locationcategory_Organizationobjectid] ON [dbo].[LocationCategory] ([organizationObjectId]) INCLUDE ([parentObjectId], [depth], [lineage], [LocationCategoryTypeObjectId], [version], [externalId])
CREATE NONCLUSTERED INDEX [IX_LocationCategory_organizationObjectId_objectId] ON [dbo].[LocationCategory] ([organizationObjectId]) INCLUDE ([objectId], [name], [parentObjectId], [depth], [lineage], [LocationCategoryTypeObjectId], [version], [externalId], [rootObjectId], [leftExtent])
CREATE NONCLUSTERED INDEX [ix_LocationCategory_parentobjectid] ON [dbo].[LocationCategory] ([parentObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [IX_LocationCategory_root_left_right] ON [dbo].[LocationCategory] ([rootObjectId], [leftExtent], [rightExtent]) INCLUDE ([name], [organizationObjectId], [parentObjectId], [depth])

GO
