CREATE TABLE [dbo].[PromptEventTriggersTag] (
   [promptEventTriggerObjectId] [int] NOT NULL,
   [tagObjectId] [int] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [sentiment] [int] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_PromptEventTriggersTag] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [tagObjectId])
)


GO
