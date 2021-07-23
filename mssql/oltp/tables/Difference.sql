CREATE TABLE [dbo].[Difference] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [MSdifftool_ErrorCode] [smallint] NULL,
   [MSdifftool_ErrorDescription] [varchar](50) NULL,
   [MSdifftool_FixSQL] [ntext] NULL,
   [MSdifftool_OffendingColumns] [ntext] NULL
)


GO
