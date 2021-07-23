CREATE TABLE [dbo].[PageLogEntry] (
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
   [queryTime] [int] NOT NULL
       DEFAULT ((0)),
   [localeKey] [varchar](25) NULL,
   [outputFormatTypeName] [varchar](50) NULL,
   [consumerName] [varchar](200) NULL,
   [completed] [bit] NOT NULL
       DEFAULT ((0)),
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

   ,CONSTRAINT [PK_PageLogEntry] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PageLogEntry_by_CreationDateTime] ON [dbo].[PageLogEntry] ([creationDateTime], [pageScheduleObjectId])
CREATE NONCLUSTERED INDEX [IX_PageLogEntry_by_Page] ON [dbo].[PageLogEntry] ([pageObjectId]) INCLUDE ([pageScheduleObjectId], [objectId])
CREATE NONCLUSTERED INDEX [IX_PageLogEntry_by_PageSchedule] ON [dbo].[PageLogEntry] ([pageScheduleObjectId], [creationDateTime])
CREATE NONCLUSTERED INDEX [IX_PageLogEntry_DeliveryRunLogEntry_PageSchedule_Page] ON [dbo].[PageLogEntry] ([deliveryRunLogEntryId], [pageScheduleObjectId], [pageObjectId]) INCLUDE ([exception], [elapsedTime], [rows])
CREATE NONCLUSTERED INDEX [IX_PageLogEntry_deliveryRunLogEntryId_completed] ON [dbo].[PageLogEntry] ([deliveryRunLogEntryId], [completed])

GO
