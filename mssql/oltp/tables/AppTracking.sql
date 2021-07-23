CREATE TABLE [dbo].[AppTracking] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [page] [varchar](100) NOT NULL,
   [trackingKey] [varchar](300) NOT NULL,
   [organizationId] [int] NULL,
   [userAccountId] [int] NULL,
   [locationId] [int] NULL,
   [reportId] [int] NULL,
   [dashboardId] [int] NULL,
   [clickDate] [datetime] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_AppTracking] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_AppTracking_By_ClickDate_TrackingKey] ON [dbo].[AppTracking] ([clickDate], [trackingKey])

GO
