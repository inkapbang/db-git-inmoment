CREATE TABLE [dbo].[tmp_blob_delete] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](250) NULL,
   [contentType] [int] NOT NULL,
   [length] [int] NOT NULL,
   [lastModifiedDate] [datetime] NOT NULL,
   [version] [int] NOT NULL
)


GO
