CREATE TABLE [dbo].[Blob] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](250) NULL,
   [contentType] [int] NOT NULL,
   [content] [varbinary](max) NULL,
   [length] [int] NOT NULL,
   [lastModifiedDate] [datetime] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [secure] [tinyint] NULL,
   [blobUuid] [varchar](36) NOT NULL
      CONSTRAINT [blob_blobuuid_default] DEFAULT (CONVERT([varchar](36),newid(),0))

   ,CONSTRAINT [PK_Blob] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Blob_contentType] ON [dbo].[Blob] ([contentType])
CREATE NONCLUSTERED INDEX [IX_Blob_length] ON [dbo].[Blob] ([length], [objectId])
CREATE UNIQUE NONCLUSTERED INDEX [UK_Blob_blobUuid] ON [dbo].[Blob] ([blobUuid]) WHERE ([blobUuid] IS NOT NULL)

GO
