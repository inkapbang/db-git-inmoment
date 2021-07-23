CREATE TABLE [dbo].[PlumServerStatus] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [plumServerObjectId] [int] NOT NULL,
   [timestamp] [datetime] NOT NULL,
   [statusType] [int] NOT NULL,
   [message] [nvarchar](max) NULL,
   [usedChannels] [int] NOT NULL,
   [connectedChannels] [int] NOT NULL,
   [suspiciousChannels] [int] NOT NULL,
   [stuckChannels] [int] NOT NULL,
   [callsTaken] [int] NOT NULL,
   [uptimeSeconds] [int] NOT NULL,
   [plumVersion] [nvarchar](100) NULL,
   [connectingCalls] [bit] NOT NULL

   ,CONSTRAINT [PK_PlumServerStatus] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PlumServerStatus_plumServerObjectId] ON [dbo].[PlumServerStatus] ([plumServerObjectId])
CREATE NONCLUSTERED INDEX [IX_PlumServerStatus_timestamp_PlumServer] ON [dbo].[PlumServerStatus] ([timestamp], [plumServerObjectId])

GO
