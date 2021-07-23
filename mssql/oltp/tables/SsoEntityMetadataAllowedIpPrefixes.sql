CREATE TABLE [dbo].[SsoEntityMetadataAllowedIpPrefixes] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [ssoEntityMetadataObjectId] [int] NOT NULL,
   [name] [nvarchar](100) NOT NULL,
   [prefix] [nvarchar](46) NOT NULL

   ,CONSTRAINT [PK_SsoEntityMetadataAllowedIpPrefixes] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SsoEntityMetadataAllowedIpPrefixes_SsoEntityMetadata] ON [dbo].[SsoEntityMetadataAllowedIpPrefixes] ([ssoEntityMetadataObjectId])

GO
