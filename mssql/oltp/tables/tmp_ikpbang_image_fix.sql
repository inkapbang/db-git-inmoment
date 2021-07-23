CREATE TABLE [dbo].[tmp_ikpbang_image_fix] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](250) NULL,
   [contentType] [int] NOT NULL,
   [length] [int] NOT NULL,
   [new_length] [bigint] NULL,
   [lastModifiedDate] [datetime] NOT NULL,
   [processedFlag] [int] NOT NULL
)


GO
