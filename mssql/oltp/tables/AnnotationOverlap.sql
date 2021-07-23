CREATE TABLE [dbo].[AnnotationOverlap] (
   [sentimentAnnotationObjectId] [int] NOT NULL,
   [tagAnnotationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_AnnotationOverlap] PRIMARY KEY CLUSTERED ([sentimentAnnotationObjectId], [tagAnnotationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_AnnotationOverlap_tagAnnotationObjectId] ON [dbo].[AnnotationOverlap] ([tagAnnotationObjectId])
CREATE NONCLUSTERED INDEX [IX_tagAnnotationObjectId] ON [dbo].[AnnotationOverlap] ([tagAnnotationObjectId])

GO
