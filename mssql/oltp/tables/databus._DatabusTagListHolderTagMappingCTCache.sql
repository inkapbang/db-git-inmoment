CREATE TABLE [databus].[_DatabusTagListHolderTagMappingCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [tagListHolderObjectId] [int] NOT NULL,
   [tagObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusTagListHolderTagMappingCTCache_tagListHolderObjectId_tagObjectId] PRIMARY KEY CLUSTERED ([tagListHolderObjectId], [tagObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusTagListHolderTagMappingCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusTagListHolderTagMappingCTCache] ([ctVersion], [ctSurrogateKey])

GO
