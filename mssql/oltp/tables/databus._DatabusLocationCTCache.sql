CREATE TABLE [databus].[_DatabusLocationCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusLocationCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusLocationCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusLocationCTCache] ([ctVersion], [ctSurrogateKey])

GO
