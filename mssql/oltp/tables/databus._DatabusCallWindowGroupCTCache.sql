CREATE TABLE [databus].[_DatabusCallWindowGroupCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusCallWindowGroupCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusCallWindowGroupCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusCallWindowGroupCTCache] ([ctVersion], [ctSurrogateKey])

GO
