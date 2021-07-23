CREATE TABLE [databus].[_DatabusUserAccountSegmentCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [userAccountObjectId] [int] NOT NULL,
   [segmentObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUserAccountSegmentCTCache_userAccountObjectId_segmentObjectId] PRIMARY KEY CLUSTERED ([userAccountObjectId], [segmentObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUserAccountSegmentCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUserAccountSegmentCTCache] ([ctVersion], [ctSurrogateKey])

GO
