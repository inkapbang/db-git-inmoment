CREATE TABLE [databus].[_DatabusHubViewFocusUpliftModelCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [hubViewObjectId] [int] NOT NULL,
   [focusUpliftModelObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusHubViewFocusUpliftModelCTCache_hubViewObjectId_focusUpliftModelObjectId] PRIMARY KEY CLUSTERED ([hubViewObjectId], [focusUpliftModelObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusHubViewFocusUpliftModelCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusHubViewFocusUpliftModelCTCache] ([ctVersion], [ctSurrogateKey])

GO
