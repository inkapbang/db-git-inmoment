CREATE TABLE [databus].[_DatabusUpliftModelActionGroupCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [upliftModelObjectId] [int] NOT NULL,
   [actionGroupObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUpliftModelActionGroupCTCache_upliftModelObjectId_actionGroupObjectId] PRIMARY KEY CLUSTERED ([upliftModelObjectId], [actionGroupObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUpliftModelActionGroupCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUpliftModelActionGroupCTCache] ([ctVersion], [ctSurrogateKey])

GO
