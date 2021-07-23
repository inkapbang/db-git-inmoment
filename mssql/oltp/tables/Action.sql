CREATE TABLE [dbo].[Action] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [labelObjectId] [int] NOT NULL,
   [actionGroupObjectId] [int] NOT NULL,
   [visibilityUnitObjectId] [int] NULL,
   [version] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [standardOperatingProcedure] [bit] NOT NULL
       DEFAULT ((0)),
   [createdDateTime] [datetime] NOT NULL
       DEFAULT (getdate()),
   [sequence] [int] NOT NULL
      CONSTRAINT [df_action_sequence] DEFAULT ((0))

   ,CONSTRAINT [PK_Action] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Action_ActionGroup] ON [dbo].[Action] ([actionGroupObjectId])
CREATE NONCLUSTERED INDEX [IX_Action_Label] ON [dbo].[Action] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_Action_Unit] ON [dbo].[Action] ([visibilityUnitObjectId])
CREATE NONCLUSTERED INDEX [IX_Action_User] ON [dbo].[Action] ([userAccountObjectId])

GO
