CREATE TABLE [dbo].[AccessEventLog] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [timestamp] [datetime] NOT NULL,
   [email] [varchar](100) NOT NULL,
   [ip] [varchar](39) NULL,
   [eventType] [int] NOT NULL,
   [userAccountObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [lockoutReason] [int] NULL

   ,CONSTRAINT [PK_AccessEventLog] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_AccessEventLog_UseraccountObjectidTimestamp] ON [dbo].[AccessEventLog] ([userAccountObjectId], [timestamp]) INCLUDE ([email], [ip], [eventType], [version])

GO
