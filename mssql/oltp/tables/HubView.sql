CREATE TABLE [dbo].[HubView] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [viewType] [int] NOT NULL,
   [labelObjectId] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [iconClass] [nvarchar](50) NULL,
   [feedbackChannelObjectId] [int] NULL,
   [dashboardId] [int] NULL,
   [decimalPrecision] [int] NULL,
   [trendPeriodObjectId] [int] NULL,
   [trendPeriodCount] [int] NULL,
   [ytdEnabled] [bit] NULL,
   [yoyEnabled] [bit] NULL,
   [targetVisible] [bit] NULL,
   [currentYearPeriodObjectId] [int] NULL,
   [groupFocusUpliftModels] [bit] NULL,
   [numUserAssignedFocusAreas] [int] NULL,
   [showCommits] [bit] NULL,
   [showLogins] [bit] NULL,
   [allowCustomPublicActions] [bit] NULL,
   [allowCustomPrivateActions] [bit] NULL,
   [SOPLimit] [int] NULL,
   [customActionLimit] [int] NULL,
   [showTags] [bit] NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [sequence] [int] NOT NULL
       DEFAULT ((0)),
   [hubViewGroupObjectId] [int] NULL,
   [name] [nvarchar](100) NOT NULL,
   [applyUserSegmentsToView] [bit] NOT NULL
      CONSTRAINT [DF_HubView_applyUserSegmentsToView] DEFAULT ((1)),
   [defaultHierarchyObjectId] [int] NULL

   ,CONSTRAINT [PK_HubView] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_HubView_defaultHierarchyObjectId] ON [dbo].[HubView] ([defaultHierarchyObjectId])
CREATE NONCLUSTERED INDEX [Ix_viewType_Orgid] ON [dbo].[HubView] ([viewType], [organizationObjectId])

GO
