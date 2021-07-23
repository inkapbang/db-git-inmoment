CREATE TABLE [dbo].[PromptEventTriggersOption] (
   [promptEventTriggerObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggersOption] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [dataFieldOptionObjectId])
)


GO
