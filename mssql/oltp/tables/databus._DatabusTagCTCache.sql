CREATE TABLE [databus].[_DatabusTagCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusTagCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusTagCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusTagCTCache] ([ctVersion], [ctSurrogateKey])

GO
