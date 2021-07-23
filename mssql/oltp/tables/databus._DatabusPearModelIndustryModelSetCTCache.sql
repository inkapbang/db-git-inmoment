CREATE TABLE [databus].[_DatabusPearModelIndustryModelSetCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [pearModelObjectId] [int] NOT NULL,
   [industryModelObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPearModelIndustryModelSetCTCache_pearModelObjectId_industryModelObjectId_sequence] PRIMARY KEY CLUSTERED ([pearModelObjectId], [industryModelObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPearModelIndustryModelSetCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPearModelIndustryModelSetCTCache] ([ctVersion], [ctSurrogateKey])

GO
