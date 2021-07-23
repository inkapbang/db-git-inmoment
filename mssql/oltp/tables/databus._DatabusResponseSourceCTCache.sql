CREATE TABLE [databus].[_DatabusResponseSourceCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusResponseSourceCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusResponseSourceCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusResponseSourceCTCache] ([ctVersion], [ctSurrogateKey])

GO
