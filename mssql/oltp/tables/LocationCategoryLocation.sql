CREATE TABLE [dbo].[LocationCategoryLocation] (
   [locationCategoryObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK__Location__DF1E1DAE6A51BEFB] PRIMARY KEY CLUSTERED ([locationCategoryObjectId], [locationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_LocationCategoryLocation_Location_LocationCategory] ON [dbo].[LocationCategoryLocation] ([locationObjectId], [locationCategoryObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [IX_LocationCategoryLocation_LocationCategory_Location] ON [dbo].[LocationCategoryLocation] ([locationCategoryObjectId], [locationObjectId])

GO
