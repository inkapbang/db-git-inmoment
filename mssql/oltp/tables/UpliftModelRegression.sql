CREATE TABLE [dbo].[UpliftModelRegression] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [modelObjectId] [int] NOT NULL,
   [ordinalModelObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_UpliftModelRegression] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_UpliftModelRegression_modelObjectId] ON [dbo].[UpliftModelRegression] ([modelObjectId])
CREATE NONCLUSTERED INDEX [IX_UpliftModelRegression_ordinalModelObjectId] ON [dbo].[UpliftModelRegression] ([ordinalModelObjectId])

GO
