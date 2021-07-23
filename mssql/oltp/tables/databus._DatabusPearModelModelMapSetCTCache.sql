CREATE TABLE [databus].[_DatabusPearModelModelMapSetCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [pearModelObjectId] [int] NOT NULL,
   [childPearModelObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPearModelModelMapSetCTCache_pearModelObjectId_childPearModelObjectId_sequence] PRIMARY KEY CLUSTERED ([pearModelObjectId], [childPearModelObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPearModelModelMapSetCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPearModelModelMapSetCTCache] ([ctVersion], [ctSurrogateKey])

GO
