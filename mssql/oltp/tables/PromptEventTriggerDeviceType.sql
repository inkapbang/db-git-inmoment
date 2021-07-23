CREATE TABLE [dbo].[PromptEventTriggerDeviceType] (
   [promptEventObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggerDeviceType] PRIMARY KEY CLUSTERED ([promptEventObjectId], [enumValue])
)


GO
