CREATE TABLE [dbo].[PearModelCategoryTagMapping] (
   [pearModelObjectId] [int] NOT NULL,
   [tagCategoryObjectId] [int] NOT NULL,
   [tagListHolderObjectId] [int] NOT NULL,
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [childPearModelObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_PearModelCategoryTagMapping] PRIMARY KEY CLUSTERED ([pearModelObjectId], [tagCategoryObjectId], [tagListHolderObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PearModelCategoryTagMapping_TagCategory] ON [dbo].[PearModelCategoryTagMapping] ([tagCategoryObjectId])
CREATE NONCLUSTERED INDEX [IX_PearModelCategoryTagMapping_TagList] ON [dbo].[PearModelCategoryTagMapping] ([tagListHolderObjectId])

GO
