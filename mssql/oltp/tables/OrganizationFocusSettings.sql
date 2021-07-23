CREATE TABLE [dbo].[OrganizationFocusSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [showCommits] [bit] NULL,
   [showLogins] [bit] NULL,
   [trendPeriodObjectId] [int] NULL,
   [showAreaMetricsTags] [int] NOT NULL
      CONSTRAINT [DF_OrganizationFocusSettings_showAreaMetricsTags] DEFAULT ((1)),
   [showLocationSummaryTags] [int] NOT NULL
      CONSTRAINT [DF_OrganizationFocusSettings_showLocationSummaryTags] DEFAULT ((1)),
   [sendRecommendationNotifications] [bit] NOT NULL
      CONSTRAINT [D_sendRecommendationNotifications] DEFAULT ((1)),
   [AllowCustomPublicActions] [bit] NOT NULL
      CONSTRAINT [D_OrganizationFocusSettings_AllowCustomPublicActions] DEFAULT ((1)),
   [AllowCustomPrivateActions] [bit] NOT NULL
      CONSTRAINT [D_OrganizationFocusSettings_AllowCustomPrivateActions] DEFAULT ((1)),
   [SOPSelectedByDefault] [bit] NULL,
   [trendShowYearOverYear] [tinyint] NOT NULL
      CONSTRAINT [DF_OrganizationFocusSettings_trendShowYearOverYear] DEFAULT ((0)),
   [trendShowYearToDate] [tinyint] NOT NULL
      CONSTRAINT [DF_OrganizationFocusSettings_trendShowYearToDate] DEFAULT ((0)),
   [currentYearPeriodObjectId] [int] NULL,
   [commentSearchPageAccess] [int] NOT NULL,
   [numUserAssignedFocusAreas] [int] NULL
      CONSTRAINT [DF_OrganizationFocusSettings_NumUserAssignedFocusAreas] DEFAULT ((0)),
   [useHierarchyMaps] [tinyint] NOT NULL
      CONSTRAINT [DF_OrganizationFocusSettings_useHierarchyMaps] DEFAULT ((0)),
   [extractPrintFromHamburgerMenu] [bit] NOT NULL
       DEFAULT ((0)),
   [coachingCommentsEnabled] [bit] NULL,
   [segmentationEnabled] [bit] NOT NULL
       DEFAULT ((0)),
   [persistedViewsEnabled] [bit] NOT NULL
       DEFAULT ((0)),
   [experienceDetailLinkDisabled] [bit] NULL
       DEFAULT ((0)),
   [wordCloudEnabled] [bit] NULL
       DEFAULT ((1)),
   [xiStatus] [tinyint] NULL
      CONSTRAINT [DF_OrganizationFocusSettings_xiStatus] DEFAULT ((0)),
   [diyDashboardEditEnabled] [bit] NULL
      CONSTRAINT [DF_OrganizationFocusSettings_diyDashboardEditEnabled] DEFAULT ((1))

   ,CONSTRAINT [PK_OrganizationFocusSettings] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationFocusSettings_currentYearPeriod] ON [dbo].[OrganizationFocusSettings] ([currentYearPeriodObjectId])
CREATE NONCLUSTERED INDEX [IX_OrganizationFocusSettings_FK_TrendPeriodObjectId_Period] ON [dbo].[OrganizationFocusSettings] ([trendPeriodObjectId])
CREATE NONCLUSTERED INDEX [IX_OrganizationFocusSettings_Organization] ON [dbo].[OrganizationFocusSettings] ([organizationObjectId])

GO
