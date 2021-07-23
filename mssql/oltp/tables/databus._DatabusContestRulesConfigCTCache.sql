CREATE TABLE [databus].[_DatabusContestRulesConfigCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusContestRulesConfigCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusContestRulesConfigCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusContestRulesConfigCTCache] ([ctVersion], [ctSurrogateKey])

GO
