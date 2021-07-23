CREATE TABLE [databus].[_DatabusUserAccountSegmentTypeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [userAccountObjectId] [int] NOT NULL,
   [segmentTypeObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUserAccountSegmentTypeCTCache_userAccountObjectId_segmentTypeObjectId] PRIMARY KEY CLUSTERED ([userAccountObjectId], [segmentTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUserAccountSegmentTypeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUserAccountSegmentTypeCTCache] ([ctVersion], [ctSurrogateKey])

GO
