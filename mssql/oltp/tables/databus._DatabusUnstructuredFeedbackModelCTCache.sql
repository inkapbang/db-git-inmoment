CREATE TABLE [databus].[_DatabusUnstructuredFeedbackModelCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUnstructuredFeedbackModelCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUnstructuredFeedbackModelCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUnstructuredFeedbackModelCTCache] ([ctVersion], [ctSurrogateKey])

GO
