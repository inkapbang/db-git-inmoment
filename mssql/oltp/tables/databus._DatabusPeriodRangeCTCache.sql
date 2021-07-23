CREATE TABLE [databus].[_DatabusPeriodRangeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPeriodRangeCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPeriodRangeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPeriodRangeCTCache] ([ctVersion], [ctSurrogateKey])

GO
