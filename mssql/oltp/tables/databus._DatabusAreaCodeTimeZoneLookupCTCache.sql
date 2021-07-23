CREATE TABLE [databus].[_DatabusAreaCodeTimeZoneLookupCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusAreaCodeTimeZoneLookupCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusAreaCodeTimeZoneLookupCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusAreaCodeTimeZoneLookupCTCache] ([ctVersion], [ctSurrogateKey])

GO
