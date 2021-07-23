CREATE TABLE [databus].[_DatabusUserAccountLocationCategoryCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [locationCategoryObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUserAccountLocationCategoryCTCache_locationCategoryObjectId_userAccountObjectId] PRIMARY KEY CLUSTERED ([locationCategoryObjectId], [userAccountObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUserAccountLocationCategoryCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUserAccountLocationCategoryCTCache] ([ctVersion], [ctSurrogateKey])

GO
