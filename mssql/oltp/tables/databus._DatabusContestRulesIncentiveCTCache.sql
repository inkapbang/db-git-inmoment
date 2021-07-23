CREATE TABLE [databus].[_DatabusContestRulesIncentiveCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusContestRulesIncentiveCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusContestRulesIncentiveCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusContestRulesIncentiveCTCache] ([ctVersion], [ctSurrogateKey])

GO
