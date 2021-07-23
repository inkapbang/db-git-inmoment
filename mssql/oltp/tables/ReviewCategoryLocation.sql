CREATE TABLE [dbo].[ReviewCategoryLocation] (
   [reviewCategoryObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK__ReviewCa__E119D8377851FEA6] PRIMARY KEY CLUSTERED ([reviewCategoryObjectId], [locationObjectId])
)

CREATE NONCLUSTERED INDEX [ix_ReviewCategoryLocation] ON [dbo].[ReviewCategoryLocation] ([locationObjectId]) INCLUDE ([reviewCategoryObjectId])

GO
