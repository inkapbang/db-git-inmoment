CREATE TABLE [databus].[_DatabusTagCategoryCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusTagCategoryCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusTagCategoryCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusTagCategoryCTCache] ([ctVersion], [ctSurrogateKey])

GO
