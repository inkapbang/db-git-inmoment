CREATE TABLE [databus].[_DatabusProgramProgressComponentEntryCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusProgramProgressComponentEntryCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusProgramProgressComponentEntryCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusProgramProgressComponentEntryCTCache] ([ctVersion], [ctSurrogateKey])

GO
