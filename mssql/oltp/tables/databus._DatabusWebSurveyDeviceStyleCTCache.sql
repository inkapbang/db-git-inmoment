CREATE TABLE [databus].[_DatabusWebSurveyDeviceStyleCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusWebSurveyDeviceStyleCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusWebSurveyDeviceStyleCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusWebSurveyDeviceStyleCTCache] ([ctVersion], [ctSurrogateKey])

GO
