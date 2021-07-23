CREATE TABLE [dbo].[OAuthToken] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [tokenKey] [nchar](36) NOT NULL,
   [expiration] [datetime] NOT NULL,
   [tokenType] [nvarchar](50) NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [webServiceClientVersionObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_OauthToken] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [U_userAccount_webServiceClientVersion] UNIQUE NONCLUSTERED ([userAccountObjectId], [webServiceClientVersionObjectId])
   ,CONSTRAINT [UK_OAuthToken_tokenKey] UNIQUE NONCLUSTERED ([tokenKey])
)

CREATE NONCLUSTERED INDEX [IX_OAuthToken_by_userAccountObjectId] ON [dbo].[OAuthToken] ([userAccountObjectId])
CREATE NONCLUSTERED INDEX [IX_OAuthToken_WebServiceClientVersion] ON [dbo].[OAuthToken] ([webServiceClientVersionObjectId])

GO
