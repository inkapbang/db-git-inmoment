CREATE TABLE [databus].[_DatabusDataFieldScoreComponentPointsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [dataFieldScoreComponentObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDataFieldScoreComponentPointsCTCache_dataFieldScoreComponentObjectId_dataFieldOptionObjectId] PRIMARY KEY CLUSTERED ([dataFieldScoreComponentObjectId], [dataFieldOptionObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDataFieldScoreComponentPointsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDataFieldScoreComponentPointsCTCache] ([ctVersion], [ctSurrogateKey])

GO
