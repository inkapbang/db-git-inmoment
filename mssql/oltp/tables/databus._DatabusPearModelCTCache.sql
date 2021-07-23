CREATE TABLE [databus].[_DatabusPearModelCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPearModelCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPearModelCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPearModelCTCache] ([ctVersion], [ctSurrogateKey])

GO
