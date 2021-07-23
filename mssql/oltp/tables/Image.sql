CREATE TABLE [dbo].[Image] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](250) NULL,
   [contentType] [int] NOT NULL,
   [content] [varbinary](max) NULL,
   [length] [int] NOT NULL,
   [lastModifiedDate] [datetime] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [secure] [tinyint] NULL
      CONSTRAINT [img_secure_default] DEFAULT ((0)),
   [blobUuid] [varchar](36) NOT NULL
      CONSTRAINT [img_blobuuid_default] DEFAULT (CONVERT([varchar](36),newid(),0))

   ,CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Image_contentType] ON [dbo].[Image] ([contentType])
CREATE NONCLUSTERED INDEX [IX_Image_length] ON [dbo].[Image] ([length], [objectId])
CREATE UNIQUE NONCLUSTERED INDEX [UK_Image_blobUuid] ON [dbo].[Image] ([blobUuid]) WHERE ([blobUuid] IS NOT NULL)

GO
