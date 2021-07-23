CREATE TABLE [dbo].[BlacklistedIdentifier] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [blacklistIdentifierType] [int] NOT NULL,
   [identifier] [nvarchar](20) NOT NULL,
   [baseAccessPolicyObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_BlacklistedIdentifier] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_BlacklistedIdentifier_BaseAccessPolicy_identifier] ON [dbo].[BlacklistedIdentifier] ([baseAccessPolicyObjectId], [blacklistIdentifierType], [identifier]) INCLUDE ([version])
CREATE NONCLUSTERED INDEX [IX_BlacklistedIdentifier_by_baseAccessPolicy] ON [dbo].[BlacklistedIdentifier] ([baseAccessPolicyObjectId])
CREATE NONCLUSTERED INDEX [IX_BlacklistedIdentifier_identifier_BaseAccessPolicy] ON [dbo].[BlacklistedIdentifier] ([identifier], [blacklistIdentifierType], [baseAccessPolicyObjectId]) INCLUDE ([version])

GO
