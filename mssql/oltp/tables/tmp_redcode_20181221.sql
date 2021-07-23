CREATE TABLE [dbo].[tmp_redcode_20181221] (
   [Market] [varchar](200) NULL,
   [Code] [varchar](200) NULL,
   [IssuableStart] [varchar](50) NULL,
   [IssuableEnd] [varchar](50) NULL,
   [LoadedDate] [varchar](50) NULL,
   [Delete] [varchar](50) NULL,
   [completeFlag] [int] NULL

)

CREATE NONCLUSTERED INDEX [ix_rc_imp] ON [dbo].[tmp_redcode_20181221] ([completeFlag]) INCLUDE ([Code], [Market])
CREATE NONCLUSTERED INDEX [ix_rc_imp2] ON [dbo].[tmp_redcode_20181221] ([Code], [Market])

GO
