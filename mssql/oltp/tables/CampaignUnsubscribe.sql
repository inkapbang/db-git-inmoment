CREATE TABLE [dbo].[CampaignUnsubscribe] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [campaignObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [contactInfo] [varchar](255) NOT NULL,
   [unsubscribeType] [int] NOT NULL,
   [dateAdded] [datetime] NOT NULL

   ,CONSTRAINT [PK_CampaignUnsubscribe] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_CampaignUnsubscribe_by_Campaign] ON [dbo].[CampaignUnsubscribe] ([campaignObjectId])
CREATE NONCLUSTERED INDEX [IX_CampaignUnsubscribe_by_Campaign_Phone] ON [dbo].[CampaignUnsubscribe] ([campaignObjectId], [contactInfo])
CREATE NONCLUSTERED INDEX [IX_CampaignUnsubscribe_by_ContactInfo] ON [dbo].[CampaignUnsubscribe] ([contactInfo], [campaignObjectId])
CREATE NONCLUSTERED INDEX [IX_CampaignUnsubscribe_campaignObjectId] ON [dbo].[CampaignUnsubscribe] ([campaignObjectId]) INCLUDE ([objectId], [version], [contactInfo], [unsubscribeType], [dateAdded])

GO
