CREATE TABLE [dbo].[Dashboard] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationId] [int] NOT NULL,
   [name] [nvarchar](100) NOT NULL,
   [labelId] [int] NOT NULL,
   [layout] [nvarchar](max) NOT NULL,
   [descriptionId] [int] NULL,
   [oldDashboardId] [int] NULL,
   [version] [int] NOT NULL,
   [dashboardType] [int] NULL,
   [userAccountObjectId] [int] NULL,
   [periodId] [int] NULL,
   [beginDate] [datetime] NULL,
   [endDate] [datetime] NULL,
   [periodTypeId] [int] NULL,
   [defaultDashboard] [bit] NULL,
   [sourceType] [int] NULL

   ,CONSTRAINT [PK_Dashboard] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Dashboard_Description_LocalizedString] ON [dbo].[Dashboard] ([descriptionId])
CREATE NONCLUSTERED INDEX [IX_Dashboard_Label_LocalizedString] ON [dbo].[Dashboard] ([labelId])
CREATE NONCLUSTERED INDEX [IX_Dashboard_organizationId_labelId_descriptionId] ON [dbo].[Dashboard] ([organizationId], [labelId], [descriptionId])
CREATE NONCLUSTERED INDEX [IX_Dashboard_Period] ON [dbo].[Dashboard] ([periodId])
CREATE NONCLUSTERED INDEX [IX_Dashboard_PeriodType] ON [dbo].[Dashboard] ([periodTypeId])
CREATE NONCLUSTERED INDEX [IX_Dashboard_userAccountObjectId] ON [dbo].[Dashboard] ([userAccountObjectId])

GO
