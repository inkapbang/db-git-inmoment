CREATE TABLE [databus].[_DatabusDnisNamedPoolCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDnisNamedPoolCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDnisNamedPoolCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDnisNamedPoolCTCache] ([ctVersion], [ctSurrogateKey])

GO
