CREATE TABLE [dbo].[PeerComparisonModel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [compareTypeId] [int] NOT NULL,
   [minUnitCount] [int] NOT NULL,
   [version] [int] NOT NULL,
   [peerTypeId] [int] NULL,
   [upliftModelId] [int] NOT NULL,
   [isPeerTypeLocation] [bit] NOT NULL
      CONSTRAINT [DF_PeerComparisonModel_isPeerTypeLocation] DEFAULT ((1))

   ,CONSTRAINT [PK_PeerComparisonModel] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PeerComparisonModel_compareTypeId] ON [dbo].[PeerComparisonModel] ([compareTypeId])
CREATE NONCLUSTERED INDEX [IX_PeerComparisonModel_peerTypeId] ON [dbo].[PeerComparisonModel] ([peerTypeId])
CREATE NONCLUSTERED INDEX [IX_PeerComparisonModel_upliftModelId] ON [dbo].[PeerComparisonModel] ([upliftModelId])

GO
