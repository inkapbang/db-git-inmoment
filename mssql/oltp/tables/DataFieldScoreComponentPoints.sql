CREATE TABLE [dbo].[DataFieldScoreComponentPoints] (
   [dataFieldScoreComponentObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL,
   [points] [float] NULL,
   [sequence] [int] NULL

   ,CONSTRAINT [PK_DataFieldScoreComponentPoints] PRIMARY KEY CLUSTERED ([dataFieldScoreComponentObjectId], [dataFieldOptionObjectId])
)

CREATE NONCLUSTERED INDEX [IX_DataFieldScoreComponentPoints_DataFieldOption] ON [dbo].[DataFieldScoreComponentPoints] ([dataFieldOptionObjectId])
CREATE NONCLUSTERED INDEX [IX_DataFieldScoreComponentPoints_DataFieldScoreComponent] ON [dbo].[DataFieldScoreComponentPoints] ([dataFieldScoreComponentObjectId])

GO
