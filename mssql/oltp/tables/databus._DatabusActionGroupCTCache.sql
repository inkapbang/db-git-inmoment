CREATE TABLE [databus].[_DatabusActionGroupCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusActionGroupCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusActionGroupCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusActionGroupCTCache] ([ctVersion], [ctSurrogateKey])

GO
