CREATE TABLE [dbo].[_Caesars_CalculationOutput] (
   [FiscalWeek] [varchar](50) NULL,
   [PeriodWeek] [varchar](10) NULL,
   [LocationId] [int] NULL,
   [LocationNumber] [varchar](50) NULL,
   [DataFieldObjectId] [int] NULL,
   [DataFieldName] [varchar](50) NULL,
   [WeightedA (10-9)] [decimal](20,8) NULL,
   [WeightedModifiedA (10-7)] [decimal](20,8) NULL,
   [WeightedF (6-0)] [decimal](20,8) NULL,
   [WeightedAll] [decimal](20,8) NULL,
   [UnweightedA (10-9)] [int] NULL,
   [UnweightedModifiedA (10-7)] [int] NULL,
   [UnweightedF (6-0)] [int] NULL,
   [UnweightedAll] [int] NULL,
   [SurveyCount] [int] NULL

)

CREATE NONCLUSTERED INDEX [idxA] ON [dbo].[_Caesars_CalculationOutput] ([FiscalWeek], [LocationNumber], [DataFieldObjectId])

GO
