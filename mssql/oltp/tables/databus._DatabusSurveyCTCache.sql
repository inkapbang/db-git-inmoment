CREATE TABLE [databus].[_DatabusSurveyCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSurveyCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSurveyCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSurveyCTCache] ([ctVersion], [ctSurrogateKey])

GO
