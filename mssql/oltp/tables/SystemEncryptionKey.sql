CREATE TABLE [dbo].[SystemEncryptionKey] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [encryptiontype] [int] NOT NULL,
   [keyPassword] [varchar](30) NULL,
   [keyAlias] [varchar](100) NULL,
   [publicKey] [varbinary](max) NULL,
   [privateKey] [varbinary](max) NULL,
   [version] [int] NULL

   ,CONSTRAINT [PK_SystemEncryptionKey] PRIMARY KEY CLUSTERED ([objectId])
)


GO
