CREATE TABLE [dbo].[SmartCommentAnnotationMapping] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [annotation] [nvarchar](200) NOT NULL,
   [annotationType] [int] NOT NULL,
   [category] [int] NOT NULL,
   [question] [nvarchar](500) NULL,
   [pearModelObjectId] [int] NULL

   ,CONSTRAINT [PK_SmartCommentAnnotationMapping] PRIMARY KEY CLUSTERED ([objectId])
)


GO
