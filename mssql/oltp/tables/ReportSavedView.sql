CREATE TABLE [dbo].[ReportSavedView] (
   [objectId] [bigint] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [reportObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [name] [nvarchar](1074) NOT NULL,
   [runParameters] [nvarchar](max) NOT NULL,
   [createdAt] [datetime] NOT NULL,
   [updatedAt] [datetime] NOT NULL

   ,CONSTRAINT [PK_ReportSavedView] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [ReportSavedView_organizationObjectId] ON [dbo].[ReportSavedView] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [ReportSavedView_reportObjectId] ON [dbo].[ReportSavedView] ([reportObjectId])
CREATE NONCLUSTERED INDEX [ReportSavedView_userAccountObjectId] ON [dbo].[ReportSavedView] ([userAccountObjectId])

GO
