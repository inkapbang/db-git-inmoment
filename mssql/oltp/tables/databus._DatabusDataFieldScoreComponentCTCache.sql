CREATE TABLE [databus].[_DatabusDataFieldScoreComponentCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDataFieldScoreComponentCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDataFieldScoreComponentCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDataFieldScoreComponentCTCache] ([ctVersion], [ctSurrogateKey])

GO
