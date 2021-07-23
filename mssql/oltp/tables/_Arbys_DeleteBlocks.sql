CREATE TABLE [dbo].[_Arbys_DeleteBlocks] (
   [ActionVoteId] [int] NULL,
   [OrganizationalUnitId] [int] NULL,
   [vote] [int] NULL,
   [createdDateTime] [datetime] NULL,
   [ActionId] [int] NULL,
   [ActionLabel] [nvarchar](max) NULL,
   [ActionGroupId] [int] NULL,
   [ActionGroupName] [nvarchar](200) NULL,
   [datafieldObjectId] [int] NULL,
   [datafieldoptionobjectid] [int] NULL,
   [UpliftModelId] [int] NULL,
   [UpliftModelName] [varchar](100) NULL,
   [isDeleteTarget] [bit] NULL,
   [preventDelete] [bit] NULL,
   [isDeleted] [bit] NULL
       DEFAULT ((0))

)

CREATE NONCLUSTERED INDEX [idx_flags] ON [dbo].[_Arbys_DeleteBlocks] ([isDeleteTarget], [preventDelete], [isDeleted])
CREATE NONCLUSTERED INDEX [idx_keys] ON [dbo].[_Arbys_DeleteBlocks] ([ActionVoteId], [isDeleteTarget], [preventDelete], [isDeleted])

GO
