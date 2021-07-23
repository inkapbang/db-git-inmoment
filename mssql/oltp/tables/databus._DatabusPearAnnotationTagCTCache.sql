CREATE TABLE [databus].[_DatabusPearAnnotationTagCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPearAnnotationTagCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPearAnnotationTagCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPearAnnotationTagCTCache] ([ctVersion], [ctSurrogateKey])

GO
