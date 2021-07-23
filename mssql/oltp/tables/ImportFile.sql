CREATE TABLE [dbo].[ImportFile] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [nvarchar](250) NULL,
   [contentType] [int] NOT NULL,
   [content] [varbinary](max) NULL,
   [length] [int] NOT NULL,
   [lastModifiedDate] [datetime] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [secure] [tinyint] NULL
      CONSTRAINT [importfile_secure_default] DEFAULT ((0)),
   [blobUuid] [varchar](36) NULL
      CONSTRAINT [importfile_blobuuid_default] DEFAULT (CONVERT([varchar](36),newid(),0))

   ,CONSTRAINT [PK_ImportFile] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [UK_ImportFile_blobUuid] ON [dbo].[ImportFile] ([blobUuid]) WHERE ([blobUuid] IS NOT NULL)

GO
