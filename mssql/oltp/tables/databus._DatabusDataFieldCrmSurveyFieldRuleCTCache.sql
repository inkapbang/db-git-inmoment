CREATE TABLE [databus].[_DatabusDataFieldCrmSurveyFieldRuleCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDataFieldCrmSurveyFieldRuleCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDataFieldCrmSurveyFieldRuleCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDataFieldCrmSurveyFieldRuleCTCache] ([ctVersion], [ctSurrogateKey])

GO
