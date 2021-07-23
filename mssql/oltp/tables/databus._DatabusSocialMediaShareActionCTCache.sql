CREATE TABLE [databus].[_DatabusSocialMediaShareActionCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSocialMediaShareActionCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSocialMediaShareActionCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSocialMediaShareActionCTCache] ([ctVersion], [ctSurrogateKey])

GO
