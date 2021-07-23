CREATE TABLE [databus].[_DatabusPageDataFieldCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [pageObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPageDataFieldCTCache_pageObjectId_dataFieldObjectId] PRIMARY KEY CLUSTERED ([pageObjectId], [dataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPageDataFieldCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPageDataFieldCTCache] ([ctVersion], [ctSurrogateKey])

GO
