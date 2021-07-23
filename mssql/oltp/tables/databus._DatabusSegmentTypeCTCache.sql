CREATE TABLE [databus].[_DatabusSegmentTypeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSegmentTypeCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSegmentTypeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSegmentTypeCTCache] ([ctVersion], [ctSurrogateKey])

GO
