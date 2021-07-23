CREATE TABLE [databus].[_DatabusAudioOptionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusAudioOptionCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusAudioOptionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusAudioOptionCTCache] ([ctVersion], [ctSurrogateKey])

GO
