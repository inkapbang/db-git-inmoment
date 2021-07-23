CREATE TABLE [dbo].[KeyStore] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [storeIdentity] [nvarchar](200) NOT NULL,
   [defaultCredentialObjectId] [int] NOT NULL,
   [keyStream] [varbinary](max) NOT NULL,
   [defaultAltCredentialObjectId] [int] NULL

   ,CONSTRAINT [PK_KeyStore] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_KeyStore_defaultAltCredential] ON [dbo].[KeyStore] ([defaultAltCredentialObjectId])
CREATE NONCLUSTERED INDEX [IX_KeyStore_defaultCredential] ON [dbo].[KeyStore] ([defaultCredentialObjectId])

GO
