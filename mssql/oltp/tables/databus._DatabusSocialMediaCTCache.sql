CREATE TABLE [databus].[_DatabusSocialMediaCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusSocialMediaCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusSocialMediaCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusSocialMediaCTCache] ([ctVersion], [ctSurrogateKey])

GO
