CREATE TABLE [databus].[_DatabusTagGlobalMappingCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [orgTagObjectId] [int] NOT NULL,
   [globalTagObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusTagGlobalMappingCTCache_orgTagObjectId_globalTagObjectId] PRIMARY KEY CLUSTERED ([orgTagObjectId], [globalTagObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusTagGlobalMappingCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusTagGlobalMappingCTCache] ([ctVersion], [ctSurrogateKey])

GO
