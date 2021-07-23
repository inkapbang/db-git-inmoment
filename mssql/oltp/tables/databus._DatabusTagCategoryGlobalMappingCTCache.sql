CREATE TABLE [databus].[_DatabusTagCategoryGlobalMappingCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [orgTagCategoryObjectId] [int] NOT NULL,
   [globalTagCategoryObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusTagCategoryGlobalMappingCTCache_orgTagCategoryObjectId_globalTagCategoryObjectId] PRIMARY KEY CLUSTERED ([orgTagCategoryObjectId], [globalTagCategoryObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusTagCategoryGlobalMappingCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusTagCategoryGlobalMappingCTCache] ([ctVersion], [ctSurrogateKey])

GO
