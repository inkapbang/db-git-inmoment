CREATE TABLE [dbo].[PeriodRange] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [beginDate] [datetime] NOT NULL,
   [endDate] [datetime] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [periodTypeObjectId] [int] NOT NULL,
   [labelObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PeriodRange] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_PeriodRange_label] UNIQUE NONCLUSTERED ([labelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PeriodRange_PeriodType] ON [dbo].[PeriodRange] ([periodTypeObjectId]) INCLUDE ([beginDate], [endDate], [version], [labelObjectId])
CREATE NONCLUSTERED INDEX [IX_PeriodRange_periodTypeObjectId_beginDate_endDate] ON [dbo].[PeriodRange] ([periodTypeObjectId], [beginDate], [endDate]) INCLUDE ([objectId], [version], [labelObjectId])

GO
