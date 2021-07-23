CREATE TABLE [databus].[_DatabusSweepstakesInstantWinTextPresetCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSweepstakesInstantWinTextPresetCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSweepstakesInstantWinTextPresetCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSweepstakesInstantWinTextPresetCTCache] ([ctVersion], [ctSurrogateKey])

GO
