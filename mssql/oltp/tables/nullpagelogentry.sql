CREATE TABLE [dbo].[nullpagelogentry] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [creationDateTime] [datetime] NOT NULL,
   [pageObjectId] [int] NULL,
   [pageScheduleObjectId] [int] NULL,
   [exception] [varchar](8000) NULL,
   [host] [varchar](200) NULL,
   [elapsedTime] [int] NULL,
   [version] [int] NOT NULL,
   [rows] [int] NULL,
   [webAppUrl] [varchar](100) NULL,
   [completionDateTime] [datetime] NULL,
   [contextDate] [datetime] NULL,
   [deliveryRunLogEntryId] [int] NULL,
   [criteria] [varchar](max) NULL,
   [query] [varchar](max) NULL,
   [queryTime] [int] NOT NULL,
   [localeKey] [varchar](25) NULL,
   [outputFormatTypeName] [varchar](50) NULL,
   [consumerName] [varchar](200) NULL,
   [completed] [bit] NOT NULL,
   [instanceName] [varchar](50) NULL,
   [enqueuedForDelivery] [bit] NULL,
   [pageLayoutSize] [int] NULL,
   [pageDescription] [nvarchar](100) NULL,
   [orgId] [int] NULL,
   [dataSourceType] [smallint] NULL,
   [dataSourceTypeNotHonored] [bit] NULL,
   [delegateNavigation] [bit] NULL,
   [shouldUseXiOutputFormat] [bit] NULL,
   [customizableCrosstab] [nvarchar](max) NULL
)


GO
