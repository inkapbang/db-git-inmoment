CREATE TABLE [dbo].[ScorecardCrossTabField] (
   [pageObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_ScorecardCrossTabField] PRIMARY KEY CLUSTERED ([pageObjectId], [dataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ScorecardCrossTabField_dataFieldObjectId] ON [dbo].[ScorecardCrossTabField] ([dataFieldObjectId])

GO
