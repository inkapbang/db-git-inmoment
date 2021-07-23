CREATE TABLE [databus].[_DatabusTOGGLZCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [FEATURE_NAME] [varchar](100) NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusTOGGLZCTCache_FEATURE_NAME] PRIMARY KEY CLUSTERED ([FEATURE_NAME])
)

CREATE NONCLUSTERED INDEX [IX__DatabusTOGGLZCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusTOGGLZCTCache] ([ctVersion], [ctSurrogateKey])

GO
