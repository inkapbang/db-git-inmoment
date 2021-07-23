CREATE TABLE [databus].[_DatabusPromptEventTriggerDeviceTypeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventTriggerDeviceTypeCTCache_promptEventObjectId_enumValue] PRIMARY KEY CLUSTERED ([promptEventObjectId], [enumValue])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventTriggerDeviceTypeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventTriggerDeviceTypeCTCache] ([ctVersion], [ctSurrogateKey])

GO
