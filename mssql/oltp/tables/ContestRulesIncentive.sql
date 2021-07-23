CREATE TABLE [dbo].[ContestRulesIncentive] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [contestRulesConfigObjectId] [int] NOT NULL,
   [type] [int] NOT NULL,
   [empathicaIncentiveId] [int] NOT NULL,
   [startDate] [datetime] NOT NULL,
   [endDate] [datetime] NULL

   ,CONSTRAINT [PK_ContestRulesIncentive] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ContestRulesIncentive_ContestRulesConfig] ON [dbo].[ContestRulesIncentive] ([contestRulesConfigObjectId])

GO
