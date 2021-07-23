CREATE TABLE [databus].[_DatabusLocalizedStringCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusLocalizedStringCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusLocalizedStringCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusLocalizedStringCTCache] ([ctVersion], [ctSurrogateKey])

GO
