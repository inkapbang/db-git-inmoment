CREATE TABLE [dbo].[KeyEntry] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [keyType] [int] NOT NULL,
   [keyStoreObjectId] [int] NOT NULL,
   [alias] [nvarchar](200) NOT NULL,
   [creationDate] [datetime] NOT NULL,
   [keyData] [varbinary](max) NOT NULL,
   [keyIdentity] [nvarchar](200) NULL,
   [signingCertificateObjectId] [int] NULL

   ,CONSTRAINT [PK_KeyEntry] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_KeyEntry_KeyEntry] ON [dbo].[KeyEntry] ([signingCertificateObjectId])
CREATE NONCLUSTERED INDEX [IX_KeyEntry_KeyStore] ON [dbo].[KeyEntry] ([keyStoreObjectId])

GO
