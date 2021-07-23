CREATE TABLE [dbo].[tmp_rc_20181221] (
   [Market] [varchar](200) NULL,
   [Code] [varchar](200) NULL,
   [completeFlag] [int] NULL

)

CREATE NONCLUSTERED INDEX [ix_rc20181221_imp] ON [dbo].[tmp_rc_20181221] ([completeFlag]) INCLUDE ([Code], [Market])
CREATE NONCLUSTERED INDEX [ix_rc20181221_imp2] ON [dbo].[tmp_rc_20181221] ([Code], [Market])

GO
