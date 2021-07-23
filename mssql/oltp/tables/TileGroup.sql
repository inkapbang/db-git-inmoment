CREATE TABLE [dbo].[TileGroup] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [peerComparisonModelId] [int] NOT NULL,
   [nameId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [display] [bit] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_TileGroup] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_TileGroup_nameId] ON [dbo].[TileGroup] ([nameId])
CREATE NONCLUSTERED INDEX [IX_TileGroup_PeerComparisonModelId] ON [dbo].[TileGroup] ([peerComparisonModelId])
CREATE NONCLUSTERED INDEX [IX_TileGroup_Sequence] ON [dbo].[TileGroup] ([sequence])

GO
