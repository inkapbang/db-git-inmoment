CREATE TABLE [databus].[_DatabusContactInfoCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusContactInfoCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusContactInfoCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusContactInfoCTCache] ([ctVersion], [ctSurrogateKey])

GO
