CREATE TABLE [databus].[_DatabusPageCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPageCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPageCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPageCTCache] ([ctVersion], [ctSurrogateKey])

GO
