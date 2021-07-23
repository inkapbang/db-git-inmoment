CREATE TABLE [dbo].[PearModelIndustryModelSet] (
   [pearModelObjectId] [int] NOT NULL,
   [industryModelObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK__PearMode__52822EF67B07AD45] PRIMARY KEY CLUSTERED ([pearModelObjectId], [industryModelObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX_PearModelIndustryModelSet_IndustryModel] ON [dbo].[PearModelIndustryModelSet] ([industryModelObjectId])

GO
