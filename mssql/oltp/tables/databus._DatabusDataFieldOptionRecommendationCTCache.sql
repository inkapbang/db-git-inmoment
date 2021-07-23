CREATE TABLE [databus].[_DatabusDataFieldOptionRecommendationCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [dataFieldOptionObjectId] [int] NOT NULL,
   [upliftModelObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDataFieldOptionRecommendationCTCache_dataFieldOptionObjectId_upliftModelObjectId] PRIMARY KEY CLUSTERED ([dataFieldOptionObjectId], [upliftModelObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDataFieldOptionRecommendationCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDataFieldOptionRecommendationCTCache] ([ctVersion], [ctSurrogateKey])

GO
