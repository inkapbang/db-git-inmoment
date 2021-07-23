CREATE TABLE [dbo].[FtpProfile] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NULL,
   [host] [varchar](200) NOT NULL,
   [port] [int] NULL,
   [protocol] [int] NOT NULL,
   [username] [varchar](100) NOT NULL,
   [password] [nvarchar](150) NULL,
   [publicKeyAuthentication] [bit] NOT NULL
       DEFAULT ((0)),
   [userKeyPassPhrase] [nvarchar](150) NULL,
   [userKeyObjectId] [int] NULL,
   [encrypt] [bit] NOT NULL
       DEFAULT ((0)),
   [encryptionType] [int] NULL,
   [encryptionKeyObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [enabled] [bit] NOT NULL
       DEFAULT ((1)),
   [useAsciiArmor] [bit] NULL,
   [controlEncoding] [int] NULL,
   [useActiveMode] [bit] NULL

   ,CONSTRAINT [PK__FtpProfile__0B7F0D80] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_FtpProfile_by_EncryptionKeyObjectid] ON [dbo].[FtpProfile] ([encryptionKeyObjectId])
CREATE NONCLUSTERED INDEX [IX_FtpProfile_by_UserKeyObjectid] ON [dbo].[FtpProfile] ([userKeyObjectId])
CREATE NONCLUSTERED INDEX [IX_FtpProfile_organizationObjectId] ON [dbo].[FtpProfile] ([organizationObjectId])

GO
