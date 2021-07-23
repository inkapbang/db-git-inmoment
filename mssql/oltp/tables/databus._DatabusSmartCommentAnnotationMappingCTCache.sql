CREATE TABLE [databus].[_DatabusSmartCommentAnnotationMappingCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSmartCommentAnnotationMappingCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSmartCommentAnnotationMappingCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSmartCommentAnnotationMappingCTCache] ([ctVersion], [ctSurrogateKey])

GO
