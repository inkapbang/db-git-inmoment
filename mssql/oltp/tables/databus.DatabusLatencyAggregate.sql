CREATE TABLE [databus].[DatabusLatencyAggregate] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [aggregateType] [tinyint] NOT NULL,
   [creationTimestamp] [datetime] NOT NULL,
   [throttlingTriggered] [bit] NOT NULL,
   [seconds] [bigint] NOT NULL,
   [records] [bigint] NOT NULL,
   [estimateSeconds] [bigint] NOT NULL,
   [maxChangesPerSecond] [float] NOT NULL

   ,CONSTRAINT [PK_DatabusLatencyAggregate] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DatabusLatencyAggregate_aggregateType_creationTimestamp] ON [databus].[DatabusLatencyAggregate] ([aggregateType], [creationTimestamp])

GO
