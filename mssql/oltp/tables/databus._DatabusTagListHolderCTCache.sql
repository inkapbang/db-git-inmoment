CREATE TABLE [databus].[_DatabusTagListHolderCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusTagListHolderCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusTagListHolderCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusTagListHolderCTCache] ([ctVersion], [ctSurrogateKey])

GO
