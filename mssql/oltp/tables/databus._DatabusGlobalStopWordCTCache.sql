CREATE TABLE [databus].[_DatabusGlobalStopWordCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusGlobalStopWordCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusGlobalStopWordCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusGlobalStopWordCTCache] ([ctVersion], [ctSurrogateKey])

GO
