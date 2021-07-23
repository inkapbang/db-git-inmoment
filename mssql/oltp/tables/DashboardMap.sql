CREATE TABLE [dbo].[DashboardMap] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [nvarchar](100) NOT NULL,
   [labelId] [int] NOT NULL,
   [hierarchyObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [live] [bit] NOT NULL,
   [dashboardType] [int] NULL

   ,CONSTRAINT [PK_DashboardMap] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardMap_hierarchyObjectId_labelId] ON [dbo].[DashboardMap] ([hierarchyObjectId], [labelId])
CREATE NONCLUSTERED INDEX [IX_DashboardMap_Label_LocalizedString] ON [dbo].[DashboardMap] ([labelId])

GO
