CREATE TABLE [dbo].[ProductionStats] (
   [rowId] [bigint] NOT NULL
      IDENTITY (1,1),
   [date] [datetime] NULL,
   [tableName] [varchar](100) NULL,
   [rowCounts] [bigint] NULL,
   [total] [bigint] NULL,
   [data] [bigint] NULL,
   [indexSize] [bigint] NULL,
   [unUsed] [bigint] NULL

)

CREATE CLUSTERED INDEX [IX_Clus_ProductionStats_RowId] ON [dbo].[ProductionStats] ([rowId], [date])
CREATE NONCLUSTERED INDEX [IX_Non_ProductionStats_Date] ON [dbo].[ProductionStats] ([date] DESC)
CREATE UNIQUE NONCLUSTERED INDEX [IX_Unq_ProductionStats_date_tableName] ON [dbo].[ProductionStats] ([date], [tableName])

GO
