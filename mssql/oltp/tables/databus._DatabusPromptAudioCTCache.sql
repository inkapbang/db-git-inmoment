CREATE TABLE [databus].[_DatabusPromptAudioCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptAudioCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptAudioCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptAudioCTCache] ([ctVersion], [ctSurrogateKey])

GO
