CREATE TABLE [dbo].[Feature] (
   [uuid] [nvarchar](36) NOT NULL,
   [tagAnnotationId] [int] NOT NULL,
   [name] [nvarchar](512) NOT NULL,
   [type] [nvarchar](512) NULL,
   [numericValue] [float] NULL,
   [booleanValue] [bit] NULL,
   [stringValue] [nvarchar](max) NULL,
   [Version] [int] NULL

   ,CONSTRAINT [PK_Feature] PRIMARY KEY CLUSTERED ([uuid])
)

CREATE NONCLUSTERED INDEX [IX_Feature_tagAnnotationId] ON [dbo].[Feature] ([tagAnnotationId])

GO
