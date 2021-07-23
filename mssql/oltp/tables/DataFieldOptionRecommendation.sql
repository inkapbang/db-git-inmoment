CREATE TABLE [dbo].[DataFieldOptionRecommendation] (
   [dataFieldOptionObjectId] [int] NOT NULL,
   [upliftModelObjectId] [int] NOT NULL,
   [localizedStringObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_DataFieldOptionRecommendation] PRIMARY KEY CLUSTERED ([dataFieldOptionObjectId], [upliftModelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_DataFieldOptionRecommendation_localizedStringObjectId] ON [dbo].[DataFieldOptionRecommendation] ([localizedStringObjectId])
CREATE NONCLUSTERED INDEX [IX_DataFieldOptionRecommendation_upliftModelObjectId] ON [dbo].[DataFieldOptionRecommendation] ([upliftModelObjectId])

GO
