CREATE TABLE [dbo].[ReportColumnComputation] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [colAColumnObjectId] [int] NOT NULL,
   [colBColumnObjectId] [int] NOT NULL,
   [operation] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_ReportColumnComputation] PRIMARY KEY CLUSTERED ([objectId] DESC)
)

CREATE NONCLUSTERED INDEX [IX_ReportColumnComputation_colAColumnObjectId] ON [dbo].[ReportColumnComputation] ([colAColumnObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportColumnComputation_colBColumnObjectId] ON [dbo].[ReportColumnComputation] ([colBColumnObjectId])

GO
