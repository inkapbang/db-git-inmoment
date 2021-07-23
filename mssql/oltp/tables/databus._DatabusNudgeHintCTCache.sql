CREATE TABLE [databus].[_DatabusNudgeHintCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [trigger] [nvarchar](400) NOT NULL,
   [locale] [varchar](20) NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusNudgeHintCTCache_trigger_locale] PRIMARY KEY CLUSTERED ([trigger], [locale])
)

CREATE NONCLUSTERED INDEX [IX__DatabusNudgeHintCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusNudgeHintCTCache] ([ctVersion], [ctSurrogateKey])

GO
