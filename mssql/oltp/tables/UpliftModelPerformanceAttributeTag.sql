CREATE TABLE [dbo].[UpliftModelPerformanceAttributeTag] (
   [performanceAttributeObjectId] [int] NOT NULL,
   [tagObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_UpliftModelPerformanceAttributeTag] PRIMARY KEY CLUSTERED ([performanceAttributeObjectId], [tagObjectId])
)


GO
