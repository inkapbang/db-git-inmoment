CREATE TABLE [dbo].[DashboardComponentGridInfo] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [dashboardComponentObjectId] [int] NOT NULL,
   [row] [int] NULL,
   [col] [int] NULL,
   [sizeX] [int] NULL,
   [sizeY] [int] NULL

   ,CONSTRAINT [PK_DashboardComponentGridInfo] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardComponentGridInfo_dashboardComponentObjectId] ON [dbo].[DashboardComponentGridInfo] ([dashboardComponentObjectId])

GO
