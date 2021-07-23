CREATE TABLE [dbo].[PageCriterionCampaign] (
   [pageCriterionObjectId] [int] NOT NULL,
   [campaignObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_ReportCriterionCampaign] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [campaignObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionCampaign_campaignId_pageCriterionId] ON [dbo].[PageCriterionCampaign] ([campaignObjectId], [pageCriterionObjectId])
CREATE NONCLUSTERED INDEX [IX_PageCriterionCampaign_pageCriterionId_campaignId] ON [dbo].[PageCriterionCampaign] ([pageCriterionObjectId], [campaignObjectId])

GO
