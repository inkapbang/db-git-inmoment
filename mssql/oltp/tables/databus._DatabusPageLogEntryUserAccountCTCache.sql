CREATE TABLE [databus].[_DatabusPageLogEntryUserAccountCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [pageLogEntryObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPageLogEntryUserAccountCTCache_pageLogEntryObjectId_userAccountObjectId] PRIMARY KEY CLUSTERED ([pageLogEntryObjectId], [userAccountObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPageLogEntryUserAccountCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPageLogEntryUserAccountCTCache] ([ctVersion], [ctSurrogateKey])

GO
