CREATE TABLE [databus].[_DatabusPearModelCategoryTagMappingCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [pearModelObjectId] [int] NOT NULL,
   [tagCategoryObjectId] [int] NOT NULL,
   [tagListHolderObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPearModelCategoryTagMappingCTCache_pearModelObjectId_tagCategoryObjectId_tagListHolderObjectId] PRIMARY KEY CLUSTERED ([pearModelObjectId], [tagCategoryObjectId], [tagListHolderObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPearModelCategoryTagMappingCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPearModelCategoryTagMappingCTCache] ([ctVersion], [ctSurrogateKey])

GO
