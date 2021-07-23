CREATE TABLE [databus].[_DatabusEmailInformationCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusEmailInformationCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusEmailInformationCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusEmailInformationCTCache] ([ctVersion], [ctSurrogateKey])

GO
