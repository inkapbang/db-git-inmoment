CREATE TABLE [databus].[_DatabusCallWindowCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusCallWindowCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusCallWindowCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusCallWindowCTCache] ([ctVersion], [ctSurrogateKey])

GO
