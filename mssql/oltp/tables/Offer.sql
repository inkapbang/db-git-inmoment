CREATE TABLE [dbo].[Offer] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [description] [varchar](2000) NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [channelObjectId] [int] NOT NULL,
   [externalId] [varchar](255) NULL

   ,CONSTRAINT [PK_Offer] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Offer_FeedbackChannel] ON [dbo].[Offer] ([channelObjectId])
CREATE NONCLUSTERED INDEX [IX_Offer_ObjectId_version] ON [dbo].[Offer] ([objectId], [version])
CREATE NONCLUSTERED INDEX [IX_Offer_organizationObjectId] ON [dbo].[Offer] ([organizationObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [UK_Offer_externalId_organizationId] ON [dbo].[Offer] ([externalId], [organizationObjectId]) WHERE ([externalId] IS NOT NULL)

GO
