CREATE TABLE [dbo].[PearModelModelMapSet] (
   [pearModelObjectId] [int] NOT NULL,
   [childPearModelObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK__PearMode__4F5F8FF2310D8521] PRIMARY KEY CLUSTERED ([pearModelObjectId], [childPearModelObjectId], [sequence])
)


GO
