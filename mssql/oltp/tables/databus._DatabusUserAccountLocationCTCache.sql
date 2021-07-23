CREATE TABLE [databus].[_DatabusUserAccountLocationCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [userAccountObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUserAccountLocationCTCache_userAccountObjectId_locationObjectId] PRIMARY KEY CLUSTERED ([userAccountObjectId], [locationObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUserAccountLocationCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUserAccountLocationCTCache] ([ctVersion], [ctSurrogateKey])

GO
