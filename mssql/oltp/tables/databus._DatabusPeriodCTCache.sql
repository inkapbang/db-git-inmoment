CREATE TABLE [databus].[_DatabusPeriodCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPeriodCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPeriodCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPeriodCTCache] ([ctVersion], [ctSurrogateKey])

GO
