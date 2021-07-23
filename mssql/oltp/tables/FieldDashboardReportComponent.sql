CREATE TABLE [dbo].[FieldDashboardReportComponent] (
   [objectId] [bigint] NOT NULL
      IDENTITY (1,1),
   [pageObjectId] [int] NOT NULL,
   [chartConfigId] [nvarchar](100) NOT NULL,
   [positionX] [int] NOT NULL,
   [positionY] [int] NOT NULL,
   [sizeX] [int] NOT NULL,
   [sizeY] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_FieldDashboardReportComponent] PRIMARY KEY CLUSTERED ([objectId])
)


GO
