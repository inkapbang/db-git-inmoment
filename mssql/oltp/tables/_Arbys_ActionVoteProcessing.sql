CREATE TABLE [dbo].[_Arbys_ActionVoteProcessing] (
   [ActionVoteId] [int] NULL,
   [OrganizationalUnitId] [int] NULL,
   [vote] [int] NULL,
   [createdDateTime] [datetime] NULL,
   [ActionId] [int] NULL,
   [ActionLabel] [nvarchar](max) NULL,
   [ActionGroupId] [int] NULL,
   [ActionGroupName] [nvarchar](200) NULL,
   [datafieldObjectId] [int] NULL,
   [datafieldOptionObjectId] [int] NULL,
   [UpliftModelId] [int] NULL,
   [UpliftModelName] [varchar](100) NULL,
   [isDeleteTarget] [bit] NULL
       DEFAULT ((0)),
   [preventDelete] [bit] NULL
       DEFAULT ((0))
)


GO
