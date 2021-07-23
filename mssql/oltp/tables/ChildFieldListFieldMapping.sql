CREATE TABLE [dbo].[ChildFieldListFieldMapping] (
   [childFieldListObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_ChildFieldListFieldMapping] PRIMARY KEY CLUSTERED ([childFieldListObjectId], [dataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ChildFieldListFieldMapping_Field] ON [dbo].[ChildFieldListFieldMapping] ([dataFieldObjectId])

GO
