CREATE TABLE [dbo].[DeliveryQueue] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [deliveryType] [int] NOT NULL,
   [pageScheduleObjectId] [int] NULL,
   [fileObjectId] [int] NULL,
   [retryCount] [int] NULL,
   [toAddresses] [varchar](max) NULL,
   [fromAddress] [varchar](max) NULL,
   [fromName] [varchar](100) NULL,
   [subject] [nvarchar](250) NULL,
   [invalidAddresses] [varchar](max) NULL,
   [validSentAddresses] [varchar](max) NULL,
   [validUnsentAddresses] [varchar](max) NULL,
   [replyToAddress] [varchar](max) NULL,
   [creationDateTime] [datetime] NULL,
   [sentDateTime] [datetime] NULL,
   [resultMessage] [varchar](500) NULL,
   [version] [int] NOT NULL
      CONSTRAINT [DF__DeliveryQ__versi__19CD2CD7] DEFAULT ((0)),
   [deliveryStatus] [int] NOT NULL,
   [pageObjectId] [int] NULL,
   [periodString] [varchar](max) NULL,
   [openedCount] [int] NOT NULL
      CONSTRAINT [df_openedCount] DEFAULT ((0)),
   [organizationObjectId] [int] NULL,
   [messageHtmlBlobId] [varchar](128) NULL,
   [messageTextBlobId] [varchar](128) NULL,
   [uuid] [varchar](36) NULL

   ,CONSTRAINT [PK_DeliveryQueue] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_creationDateTime_deliveryStatus_deliveryType] ON [dbo].[DeliveryQueue] ([creationDateTime], [deliveryStatus], [deliveryType]) INCLUDE ([pageObjectId], [pageScheduleObjectId], [sentDateTime], [subject], [toAddresses])
CREATE NONCLUSTERED INDEX [ix_Deliveryqueue_Creationtime] ON [dbo].[DeliveryQueue] ([creationDateTime]) INCLUDE ([fileObjectId], [objectId])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_deliveryStatus_deliveryType] ON [dbo].[DeliveryQueue] ([deliveryStatus], [deliveryType])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_deliveryType_deliveryStatus] ON [dbo].[DeliveryQueue] ([deliveryType], [deliveryStatus])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_deliveryType_sentDateTime_Schedule] ON [dbo].[DeliveryQueue] ([deliveryType], [sentDateTime], [pageScheduleObjectId]) INCLUDE ([creationDateTime], [objectId])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_fileAttachment] ON [dbo].[DeliveryQueue] ([fileObjectId])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_MessageHtmlBlobId_messageTextBlobId] ON [dbo].[DeliveryQueue] ([messageHtmlBlobId], [messageTextBlobId])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_organizationObjectId] ON [dbo].[DeliveryQueue] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [ix_Deliveryqueue_OrgIDPageID] ON [dbo].[DeliveryQueue] ([organizationObjectId], [pageObjectId]) INCLUDE ([objectId])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_page_deliveryType_creationDateTime] ON [dbo].[DeliveryQueue] ([pageObjectId], [deliveryType], [creationDateTime])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_pageSchedule] ON [dbo].[DeliveryQueue] ([pageScheduleObjectId], [creationDateTime] DESC) INCLUDE ([deliveryStatus], [deliveryType], [fileObjectId], [sentDateTime], [subject], [toAddresses])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_sentDateTime_dStatus_dType_retryCnt] ON [dbo].[DeliveryQueue] ([sentDateTime], [deliveryStatus], [deliveryType], [retryCount]) INCLUDE ([objectId])
CREATE NONCLUSTERED INDEX [IX_DeliveryQueue_sentDateTime_Page_PageSchedule] ON [dbo].[DeliveryQueue] ([sentDateTime], [pageObjectId], [pageScheduleObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [UK_DeliveryQueue_uuid] ON [dbo].[DeliveryQueue] ([uuid]) WHERE ([uuid] IS NOT NULL)

GO
