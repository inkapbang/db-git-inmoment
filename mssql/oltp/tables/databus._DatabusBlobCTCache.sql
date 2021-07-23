CREATE TABLE [databus].[_DatabusBlobCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusBlobCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusBlobCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusBlobCTCache] ([ctVersion], [ctSurrogateKey])

GO
