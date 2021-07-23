CREATE TABLE [dbo].[StoredFile] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [fileStoreObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [humanReadableName] [varchar](100) NOT NULL,
   [tag] [varchar](100) NULL,
   [blobObjectId] [int] NOT NULL,
   [uuid] [varchar](36) NULL,
   [secure] [tinyint] NULL

   ,CONSTRAINT [PK_StoredFile] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_StoredFile_Blob] ON [dbo].[StoredFile] ([blobObjectId])
CREATE NONCLUSTERED INDEX [IX_StoredFile_FileStore] ON [dbo].[StoredFile] ([fileStoreObjectId])

GO
