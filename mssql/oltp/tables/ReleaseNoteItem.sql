CREATE TABLE [dbo].[ReleaseNoteItem] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [releaseObjectId] [int] NOT NULL,
   [name] [varchar](200) NOT NULL,
   [description] [varchar](max) NOT NULL,
   [itemType] [int] NOT NULL,
   [internalOnly] [bit] NOT NULL,
   [developer] [varchar](1000) NOT NULL,
   [requester] [varchar](1000) NOT NULL,
   [tpIds] [varchar](1000) NOT NULL

   ,CONSTRAINT [PK_ReleaseNoteItem] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ReleaseNoteItem_ReleaseNote] ON [dbo].[ReleaseNoteItem] ([releaseObjectId])

GO
