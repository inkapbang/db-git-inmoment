CREATE TABLE [dbo].[_DBA8451_Newsletter_Opt2] (
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
   [version] [int] NOT NULL,
   [deliveryStatus] [int] NOT NULL,
   [pageObjectId] [int] NULL,
   [periodString] [varchar](max) NULL,
   [openedCount] [int] NOT NULL,
   [organizationObjectId] [int] NULL,
   [messageHtmlBlobId] [varchar](128) NULL,
   [messageTextBlobId] [varchar](128) NULL,
   [uuid] [varchar](36) NULL
)


GO
