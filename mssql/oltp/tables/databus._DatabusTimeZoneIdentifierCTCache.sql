CREATE TABLE [databus].[_DatabusTimeZoneIdentifierCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusTimeZoneIdentifierCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusTimeZoneIdentifierCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusTimeZoneIdentifierCTCache] ([ctVersion], [ctSurrogateKey])

GO
