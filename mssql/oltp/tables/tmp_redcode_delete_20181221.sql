CREATE TABLE [dbo].[tmp_redcode_delete_20181221] (
   [Market] [varchar](200) NULL,
   [Code] [varchar](200) NULL

)

CREATE NONCLUSTERED INDEX [ix_rc] ON [dbo].[tmp_redcode_delete_20181221] ([Code], [Market])

GO
