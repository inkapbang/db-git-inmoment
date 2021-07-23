CREATE TABLE [databus].[_DatabusAddressCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusAddressCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusAddressCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusAddressCTCache] ([ctVersion], [ctSurrogateKey])

GO
