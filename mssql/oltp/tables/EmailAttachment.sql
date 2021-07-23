CREATE TABLE [dbo].[EmailAttachment] (
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
      CONSTRAINT [emailattch_secure_default] DEFAULT ((0)),
   [blobUuid] [varchar](36) NOT NULL
      CONSTRAINT [emailattch_blobuuid_default] DEFAULT (CONVERT([varchar](36),newid(),0))

   ,CONSTRAINT [PK_EmailAttachment] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [UK_EmailAttachment_blobUuid] ON [dbo].[EmailAttachment] ([blobUuid]) WHERE ([blobUuid] IS NOT NULL)

GO
