CREATE TABLE [databus].[_DatabusDataFieldGroupCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [dataFieldObjectId] [int] NOT NULL,
   [memberDataFieldObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDataFieldGroupCTCache_dataFieldObjectId_memberDataFieldObjectId] PRIMARY KEY CLUSTERED ([dataFieldObjectId], [memberDataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDataFieldGroupCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDataFieldGroupCTCache] ([ctVersion], [ctSurrogateKey])

GO
