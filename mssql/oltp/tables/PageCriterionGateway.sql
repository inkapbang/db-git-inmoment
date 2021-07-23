CREATE TABLE [dbo].[PageCriterionGateway] (
   [pageCriterionObjectId] [int] NOT NULL,
   [surveyGatewayObjectId] [int] NOT NULL

   ,CONSTRAINT [PK__PageCrit__248872A92B652C53] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [surveyGatewayObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionGateway_surveyGatewayObjectId] ON [dbo].[PageCriterionGateway] ([surveyGatewayObjectId])

GO
