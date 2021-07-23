CREATE TABLE [databus].[_DatabusPhoneAttemptSettingCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPhoneAttemptSettingCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPhoneAttemptSettingCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPhoneAttemptSettingCTCache] ([ctVersion], [ctSurrogateKey])

GO
