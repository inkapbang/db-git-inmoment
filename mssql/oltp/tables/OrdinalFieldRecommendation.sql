CREATE TABLE [dbo].[OrdinalFieldRecommendation] (
   [ordinalFieldObjectId] [int] NOT NULL,
   [upliftModelObjectId] [int] NOT NULL,
   [localizedStringObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_OrdinalFieldRecommendation] PRIMARY KEY CLUSTERED ([ordinalFieldObjectId], [upliftModelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OrdinalFieldRecommendation_localizedStringObjectId] ON [dbo].[OrdinalFieldRecommendation] ([localizedStringObjectId])
CREATE NONCLUSTERED INDEX [IX_OrdinalFieldRecommendation_upliftModelObjectId] ON [dbo].[OrdinalFieldRecommendation] ([upliftModelObjectId])

GO
