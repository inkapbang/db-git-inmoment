CREATE TABLE [databus].[_DatabusSweepstakesInstantWinPromptConfigCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSweepstakesInstantWinPromptConfigCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSweepstakesInstantWinPromptConfigCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSweepstakesInstantWinPromptConfigCTCache] ([ctVersion], [ctSurrogateKey])

GO
