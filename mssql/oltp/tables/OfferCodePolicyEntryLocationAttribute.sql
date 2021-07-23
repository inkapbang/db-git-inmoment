CREATE TABLE [dbo].[OfferCodePolicyEntryLocationAttribute] (
   [offerCodePolicyEntryId] [int] NOT NULL,
   [attributeObjectId] [int] NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK__OfferCod__AEB10659566FE97D] PRIMARY KEY CLUSTERED ([offerCodePolicyEntryId], [attributeObjectId])
)


GO
