CREATE TABLE [databus].[_DatabusSocialLocationCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSocialLocationCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSocialLocationCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSocialLocationCTCache] ([ctVersion], [ctSurrogateKey])

GO
