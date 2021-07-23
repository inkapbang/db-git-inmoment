CREATE TABLE [dbo].[PlumQueueStatus] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [creationDateTime] [datetime] NOT NULL,
   [host] [varchar](50) NOT NULL,
   [connectedPorts] [int] NOT NULL,
   [dialingPorts] [int] NOT NULL,
   [retryPendingPorts] [int] NOT NULL,
   [uncalledInQueue] [int] NOT NULL

   ,CONSTRAINT [PK_PlumQueueStatus] PRIMARY KEY CLUSTERED ([objectId])
)


GO
