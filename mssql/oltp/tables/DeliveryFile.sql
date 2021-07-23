CREATE TABLE [dbo].[DeliveryFile] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [nvarchar](250) NULL,
   [contentType] [int] NOT NULL,
   [length] [int] NOT NULL,
   [lastModifiedDate] [datetime] NOT NULL,
   [version] [int] NOT NULL
      CONSTRAINT [DF__DeliveryF__versi__5536A684] DEFAULT ((0)),
   [secure] [tinyint] NULL
      CONSTRAINT [dfile_secure_default] DEFAULT ((0)),
   [blobUuid] [varchar](36) NULL
      CONSTRAINT [dfile_blobuuid_default] DEFAULT (CONVERT([varchar](36),newid(),(0))),
   [contentBlobId] [varchar](128) NULL

   ,CONSTRAINT [PK_DeliveryFile] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [UK_DeliveryFile_blobUuid] ON [dbo].[DeliveryFile] ([blobUuid]) WHERE ([blobUuid] IS NOT NULL)

GO
