CREATE TABLE [dbo].[_PeerComparisonModel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [compareTypeId] [int] NOT NULL,
   [minUnitCount] [int] NOT NULL,
   [version] [int] NOT NULL,
   [peerTypeId] [int] NULL,
   [upliftModelId] [int] NOT NULL,
   [isPeerTypeLocation] [bit] NOT NULL
)


GO
