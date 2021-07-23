CREATE TABLE [dbo].[DataFieldScoreComponent] (
   [dataFieldObjectId] [int] NOT NULL,
   [scoredDataFieldObjectId] [int] NOT NULL,
   [weight] [float] NOT NULL,
   [sequence] [int] NOT NULL,
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_DataFieldScoreComponent] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_DataFieldScoreComponent_by_Field_ScoredField] ON [dbo].[DataFieldScoreComponent] ([dataFieldObjectId], [scoredDataFieldObjectId]) INCLUDE ([weight], [sequence])
CREATE NONCLUSTERED INDEX [IX_DataFieldScoreComponent_scoredDataFieldObjectId] ON [dbo].[DataFieldScoreComponent] ([scoredDataFieldObjectId])

GO
