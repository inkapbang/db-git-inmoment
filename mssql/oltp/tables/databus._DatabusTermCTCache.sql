CREATE TABLE [databus].[_DatabusTermCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [bigint] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusTermCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusTermCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusTermCTCache] ([ctVersion], [ctSurrogateKey])

GO
