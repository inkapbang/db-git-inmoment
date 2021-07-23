CREATE TABLE [dbo].[DashboardComponentChildFieldListMapping] (
   [dashboardComponentObjectId] [int] NOT NULL,
   [childFieldListObjectId] [int] NOT NULL,
   [parentFieldObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_DashboardComponentChildFieldListMapping] PRIMARY KEY CLUSTERED ([dashboardComponentObjectId], [childFieldListObjectId], [parentFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ComponentChildFieldListFieldMapping_Field] ON [dbo].[DashboardComponentChildFieldListMapping] ([parentFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_ComponentChildFieldListFieldMapping_List] ON [dbo].[DashboardComponentChildFieldListMapping] ([childFieldListObjectId])

GO
