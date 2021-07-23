CREATE TABLE [dbo].[_DashboardComponent] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [discriminator] [int] NOT NULL,
   [dashboardId] [int] NOT NULL,
   [titleId] [int] NOT NULL,
   [dashboardComponentType] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [serviceExceptionType] [int] NULL,
   [unstructuredFeedbackModelId] [int] NULL,
   [upliftModelId] [int] NULL,
   [periodId] [int] NULL,
   [renderedItemCount] [int] NULL,
   [feedbackChannelId] [int] NULL,
   [numberOfDays] [int] NULL,
   [optionalColumns] [varchar](max) NULL,
   [videoId] [varchar](32) NULL,
   [showInfo] [bit] NULL,
   [showAnnotations] [bit] NULL,
   [hd] [bit] NULL,
   [allowFullScreen] [bit] NULL,
   [delimitedConfigurationString] [nvarchar](max) NULL,
   [srcQuery] [nvarchar](max) NULL,
   [showProfileImages] [bit] NULL,
   [showUserScreenNames] [bit] NULL,
   [uuid] [uniqueidentifier] NULL,
   [scroll] [bit] NULL,
   [version] [int] NOT NULL,
   [showLocationNames] [tinyint] NULL,
   [refreshCurrentPeriod] [tinyint] NULL,
   [layout] [varchar](5000) NULL,
   [edLinkDisable] [bit] NULL,
   [periodId2] [int] NULL,
   [changeType] [int] NULL,
   [changePeriodType] [int] NULL,
   [visualization] [int] NULL,
   [responseCount] [int] NULL,
   [lockedDate] [bit] NULL,
   [lockedUnits] [bit] NULL,
   [beginDate] [datetime] NULL,
   [endDate] [datetime] NULL,
   [periodTypeId] [int] NULL,
   [lockedDate2] [bit] NULL,
   [beginDate2] [datetime] NULL,
   [endDate2] [datetime] NULL,
   [periodTypeId2] [int] NULL,
   [dateCriteriaType] [int] NULL,
   [watchlistId] [varchar](25) NULL,
   [changeOffset] [int] NULL,
   [minResponseCount] [int] NULL,
   [aggregationType] [int] NULL,
   [thresholdType] [int] NULL,
   [locationCategoryTypeId] [int] NULL,
   [dataSourceType] [int] NULL,
   [changePeriod] [int] NULL,
   [changeLocked] [bit] NULL,
   [targetEnabled] [bit] NULL
)


GO