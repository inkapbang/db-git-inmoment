CREATE TABLE [dbo].[TOGGLZbak] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [dt] [datetime] NULL,
   [FEATURE_NAME] [varchar](100) NOT NULL,
   [FEATURE_ENABLED] [int] NULL,
   [STRATEGY_ID] [varchar](100) NULL,
   [STRATEGY_PARAMS] [varchar](max) NULL

   ,CONSTRAINT [PK_TOGGLZbak] PRIMARY KEY CLUSTERED ([objectId])
)


GO
