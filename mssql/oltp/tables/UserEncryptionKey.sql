CREATE TABLE [dbo].[UserEncryptionKey] (
   [objectId] [int] NOT NULL,
   [encryptionType] [int] NOT NULL,
   [version] [int] NULL,
   [publicKeyObjectId] [int] NULL

   ,CONSTRAINT [PK_UserEncryptionKey] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_UserEncryptionKey_Blob_publicKey] ON [dbo].[UserEncryptionKey] ([publicKeyObjectId])

GO
