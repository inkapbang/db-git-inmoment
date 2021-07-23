CREATE TABLE [databus].[_DatabusLocationCategoryLocationCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [locationCategoryObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusLocationCategoryLocationCTCache_locationCategoryObjectId_locationObjectId] PRIMARY KEY CLUSTERED ([locationCategoryObjectId], [locationObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusLocationCategoryLocationCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusLocationCategoryLocationCTCache] ([ctVersion], [ctSurrogateKey])

GO
