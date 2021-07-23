CREATE TABLE [dbo].[UpliftModelActionGroup] (
   [upliftModelObjectId] [int] NOT NULL,
   [actionGroupObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_UpliftModelActionGroup] PRIMARY KEY CLUSTERED ([upliftModelObjectId], [actionGroupObjectId])
)

CREATE NONCLUSTERED INDEX [IX_UpliftModelActionGroup_ActionGroup] ON [dbo].[UpliftModelActionGroup] ([actionGroupObjectId])

GO
