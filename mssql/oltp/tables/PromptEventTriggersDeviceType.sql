CREATE TABLE [dbo].[PromptEventTriggersDeviceType] (
   [promptEventTriggerObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggersDeviceType] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [enumValue])
)


GO
