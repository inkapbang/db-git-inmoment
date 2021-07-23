CREATE TABLE [dbo].[tmp_campaignUnsubscribePurge_20180514] (
   [objectId] [int] NOT NULL,
   [campaignObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [contactInfo] [varchar](255) NOT NULL,
   [unsubscribeType] [int] NOT NULL,
   [dateAdded] [datetime] NOT NULL,
   [isProcessed] [int] NULL

)

CREATE NONCLUSTERED INDEX [IX_CUP1] ON [dbo].[tmp_campaignUnsubscribePurge_20180514] ([contactInfo], [campaignObjectId])

GO
