CREATE TABLE [databus].[_DatabusBrandCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusBrandCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusBrandCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusBrandCTCache] ([ctVersion], [ctSurrogateKey])

GO
