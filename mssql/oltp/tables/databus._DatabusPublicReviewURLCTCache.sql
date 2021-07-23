CREATE TABLE [databus].[_DatabusPublicReviewURLCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPublicReviewURLCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPublicReviewURLCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPublicReviewURLCTCache] ([ctVersion], [ctSurrogateKey])

GO
