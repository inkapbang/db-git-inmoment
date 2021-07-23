CREATE TABLE [dbo].[ReportBenchmark] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [benchmarkLabelObjectId] [int] NOT NULL,
   [benchmarkLocationCategoryTypeObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_ReportBenchmark] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_Report_benchmarkLabel] UNIQUE NONCLUSTERED ([benchmarkLabelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ReportBenchmark_benchmarkLocationCategoryTypeObjectId] ON [dbo].[ReportBenchmark] ([benchmarkLocationCategoryTypeObjectId])

GO
