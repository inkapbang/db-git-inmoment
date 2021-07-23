CREATE TABLE [databus].[_DatabusSurveyStepCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSurveyStepCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSurveyStepCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSurveyStepCTCache] ([ctVersion], [ctSurrogateKey])

GO
