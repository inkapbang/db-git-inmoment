CREATE TABLE [dbo].[ResponseCriterionSource] (
   [responseCriterionObjectId] [int] NOT NULL,
   [responseSourceObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_ResponseCriterionSource] PRIMARY KEY CLUSTERED ([responseCriterionObjectId], [responseSourceObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ResponseCriterionSource_responseSourceObjectId] ON [dbo].[ResponseCriterionSource] ([responseSourceObjectId])

GO
