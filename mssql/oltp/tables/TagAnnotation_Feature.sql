CREATE TABLE [dbo].[TagAnnotation_Feature] (
   [feature_uuid] [nvarchar](36) NOT NULL,
   [tagAnnotationId] [int] NOT NULL,
   [feature_name] [nvarchar](512) NOT NULL,
   [feature_type] [nvarchar](512) NULL,
   [feature_numericValue] [float] NULL,
   [feature_booleanValue] [bit] NULL,
   [feature_stringValue] [nvarchar](max) NULL,
   [features_uuid] [nvarchar](36) NULL,
   [TagAnnotation_objectId] [int] NULL

   ,CONSTRAINT [PK_TagAnnotation_Feature] PRIMARY KEY CLUSTERED ([feature_uuid])
)


GO
