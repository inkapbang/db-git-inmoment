CREATE TABLE [dbo].[HubViewTagMap] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [viewType] [nvarchar](100) NOT NULL,
   [dashboardObjectId] [int] NULL,
   [viewObjectId] [int] NULL,
   [isDashboardView] [bit] NOT NULL
       DEFAULT ((0)),
   [tagName] [nvarchar](100) NULL

   ,CONSTRAINT [PK_HubViewTagMap] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HubViewTagMap_organizationObjectId] ON [dbo].[HubViewTagMap] ([organizationObjectId])

GO
