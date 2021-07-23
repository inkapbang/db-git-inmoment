CREATE TABLE [dbo].[RedemptionCode] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [offerCodeObjectId] [int] NOT NULL,
   [redemptionCode] [int] NOT NULL
       DEFAULT (1000),
   [version] [int] NOT NULL
       DEFAULT (0)

   ,CONSTRAINT [PK__RedemptionCode__1784265B] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_RedemptionCode_by_OfferCode] ON [dbo].[RedemptionCode] ([offerCodeObjectId])

GO
