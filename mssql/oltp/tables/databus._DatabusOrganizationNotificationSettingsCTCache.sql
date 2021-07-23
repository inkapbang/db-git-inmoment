CREATE TABLE [databus].[_DatabusOrganizationNotificationSettingsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationNotificationSettingsCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationNotificationSettingsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationNotificationSettingsCTCache] ([ctVersion], [ctSurrogateKey])

GO
