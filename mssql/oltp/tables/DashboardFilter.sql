CREATE TABLE [dbo].[DashboardFilter] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [filterType] [int] NOT NULL,
   [version] [int] NOT NULL,
   [dashboardId] [int] NULL,
   [componentId] [int] NULL,
   [sequence] [int] NULL,
   [labelId] [int] NOT NULL,
   [dataFieldId] [int] NULL,
   [locationAttributeGroupId] [int] NULL,
   [locked] [bit] NULL,
   [tagCategoryId] [int] NULL,
   [mltCommentObjectId] [int] NULL

   ,CONSTRAINT [PK_DashboardFilter] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardFilter_ComponentId] ON [dbo].[DashboardFilter] ([componentId])
CREATE NONCLUSTERED INDEX [IX_DashboardFilter_DashboardId] ON [dbo].[DashboardFilter] ([dashboardId])
CREATE NONCLUSTERED INDEX [IX_DashboardFilter_dataFieldId] ON [dbo].[DashboardFilter] ([dataFieldId])
CREATE NONCLUSTERED INDEX [IX_DashboardFilter_LabeId] ON [dbo].[DashboardFilter] ([labelId])
CREATE NONCLUSTERED INDEX [IX_DashboardFilter_LocationAttributeGroupId] ON [dbo].[DashboardFilter] ([locationAttributeGroupId])
CREATE NONCLUSTERED INDEX [IX_DashboardFilter_TagCategoryId] ON [dbo].[DashboardFilter] ([tagCategoryId])

GO
