CREATE TABLE [dbo].[temp_TOGGLZ] (
   [FEATURE_NAME] [varchar](100) NOT NULL,
   [FEATURE_ENABLED] [int] NULL,
   [STRATEGY_ID] [varchar](100) NULL,
   [STRATEGY_PARAMS] [varchar](max) NULL

   ,CONSTRAINT [PK_temp_TOGGLZ] PRIMARY KEY CLUSTERED ([FEATURE_NAME])
)


GO