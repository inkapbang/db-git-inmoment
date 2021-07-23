CREATE TABLE [dbo].[ReportColumnRangeFormatting] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [reportColumnObjectId] [int] NOT NULL,
   [minimum] [float] NULL,
   [maximum] [float] NULL,
   [backgroundColor] [nvarchar](50) NULL

   ,CONSTRAINT [PK_ReportColumnRangeFormatting] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ReportColumnRangeFormatting_reportColumnObjectId] ON [dbo].[ReportColumnRangeFormatting] ([reportColumnObjectId])

GO
