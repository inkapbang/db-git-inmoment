CREATE TABLE [dbo].[SsoEntityMetadata] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [nvarchar](100) NOT NULL,
   [entityId] [nvarchar](1000) NOT NULL,
   [organizationObjectId] [int] NULL,
   [signingKey] [nvarchar](200) NULL,
   [encryptionKey] [nvarchar](200) NULL,
   [tlsKey] [nvarchar](200) NULL,
   [metadataFile] [nvarchar](max) NOT NULL,
   [testingProvider] [bit] NOT NULL,
   [altSigningKey] [nvarchar](200) NULL,
   [altEncryptionKey] [nvarchar](200) NULL,
   [altTlsKey] [nvarchar](200) NULL,
   [localSigningKey] [nvarchar](200) NULL,
   [xiPortal] [bit] NOT NULL
      CONSTRAINT [DF__SsoEntity__xiPor__0F4BD34C] DEFAULT ((0)),
   [xiRedirect] [bit] NULL
      CONSTRAINT [DF_SsoEntityMetadata_xiRedirect] DEFAULT ((0))

   ,CONSTRAINT [PK_SsoEntityMetadata] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SsoEntityMetadata_Organization] ON [dbo].[SsoEntityMetadata] ([organizationObjectId])

GO
