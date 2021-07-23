CREATE TABLE [dbo].[PolicyRespondentIdentifier] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [policyObjectId] [int] NOT NULL,
   [identityType] [int] NOT NULL

   ,CONSTRAINT [PK_PolicyRespondentIdentifier] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PolicyRespondentIdentifier_BaseAccessPolicy] ON [dbo].[PolicyRespondentIdentifier] ([policyObjectId])

GO
