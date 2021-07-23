CREATE TABLE [dbo].[DeliveryRunLogEntry] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [startTime] [datetime] NOT NULL,
   [endTime] [datetime] NULL,
   [version] [int] NOT NULL,
   [internationalDateLineOffset] [varchar](10) NULL,
   [contextDate] [datetime] NULL,
   [enqueued] [bit] NOT NULL
       DEFAULT ((0)),
   [systemWide] [bit] NULL
      CONSTRAINT [DF_DeliveryRunLogEntry_systemWide] DEFAULT ((0)),
   [enqueueingUserObjectId] [int] NULL,
   [overrideRecipientUserObjectId] [int] NULL

   ,CONSTRAINT [PK_DeliveryRunLogEntry] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DeliveryRunLogEntry_ContextDate] ON [dbo].[DeliveryRunLogEntry] ([contextDate])

GO
