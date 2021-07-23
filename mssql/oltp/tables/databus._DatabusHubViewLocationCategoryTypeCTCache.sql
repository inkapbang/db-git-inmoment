CREATE TABLE [databus].[_DatabusHubViewLocationCategoryTypeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [hubViewObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusHubViewLocationCategoryTypeCTCache_hubViewObjectId_locationCategoryTypeObjectId] PRIMARY KEY CLUSTERED ([hubViewObjectId], [locationCategoryTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusHubViewLocationCategoryTypeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusHubViewLocationCategoryTypeCTCache] ([ctVersion], [ctSurrogateKey])

GO
