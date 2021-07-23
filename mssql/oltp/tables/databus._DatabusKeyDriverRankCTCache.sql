CREATE TABLE [databus].[_DatabusKeyDriverRankCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusKeyDriverRankCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusKeyDriverRankCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusKeyDriverRankCTCache] ([ctVersion], [ctSurrogateKey])

GO
