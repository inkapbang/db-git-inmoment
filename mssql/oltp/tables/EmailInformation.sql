CREATE TABLE [dbo].[EmailInformation] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [fromAddress] [varchar](500) NULL,
   [fromName] [nvarchar](500) NULL,
   [replyAddress] [varchar](500) NULL,
   [subject] [nvarchar](2000) NULL,
   [body] [nvarchar](max) NULL,
   [html] [bit] NULL,
   [deliveryFileObjectId] [int] NULL,
   [emailCampaignObjectId] [int] NULL,
   [phraseObjectId] [int] NULL,
   [version] [int] NOT NULL,
   [emailAttachmentObjectId] [int] NULL,
   [emailAddressId] [int] NULL

   ,CONSTRAINT [PK_EmailInformation] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_EmailInformation_deliveryFileObjectId] ON [dbo].[EmailInformation] ([deliveryFileObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailInformation_emailAttachmentObjectId] ON [dbo].[EmailInformation] ([emailAttachmentObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailInformation_emailCampaignObjectId] ON [dbo].[EmailInformation] ([emailCampaignObjectId])
CREATE NONCLUSTERED INDEX [IX_EmailInformation_phraseObjectId] ON [dbo].[EmailInformation] ([phraseObjectId])

GO
