CREATE TABLE [dbo].[CallWindow] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [callWindowGroupObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [name] [varchar](255) NOT NULL,
   [windowType] [int] NOT NULL,
   [makeCall] [bit] NOT NULL,
   [fromHour] [int] NOT NULL,
   [fromMinute] [int] NOT NULL,
   [toHour] [int] NOT NULL,
   [toMinute] [int] NOT NULL,
   [month] [int] NULL,
   [calDate] [int] NULL,
   [year] [int] NULL,
   [dayOfWeek] [int] NULL,
   [overrideType] [int] NULL

   ,CONSTRAINT [PK_CallWindow] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_CallWindow_by_CallWindowGroup] ON [dbo].[CallWindow] ([callWindowGroupObjectId])

GO
