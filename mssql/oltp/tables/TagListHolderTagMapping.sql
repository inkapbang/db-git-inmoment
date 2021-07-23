CREATE TABLE [dbo].[TagListHolderTagMapping] (
   [tagListHolderObjectId] [int] NOT NULL,
   [tagObjectId] [int] NOT NULL

   ,CONSTRAINT [TagListHolderTagMapping_FK] PRIMARY KEY CLUSTERED ([tagListHolderObjectId], [tagObjectId])
)

CREATE NONCLUSTERED INDEX [IX_TagListHolderTagMapping_Tag] ON [dbo].[TagListHolderTagMapping] ([tagObjectId])

GO
