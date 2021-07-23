CREATE TABLE [dbo].[ActionVote] (
   [objectId] [bigint] NOT NULL
      IDENTITY (1,1),
   [vote] [int] NOT NULL,
   [actionObjectId] [int] NOT NULL,
   [unitObjectId] [int] NULL,
   [version] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [createdDateTime] [datetime] NOT NULL
       DEFAULT (getdate())

   ,CONSTRAINT [PK_ActionVote] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ActionVote_ActionUnitCreated] ON [dbo].[ActionVote] ([actionObjectId], [unitObjectId], [createdDateTime]) INCLUDE ([vote])
CREATE NONCLUSTERED INDEX [IX_ActionVote_Unit] ON [dbo].[ActionVote] ([unitObjectId])
CREATE NONCLUSTERED INDEX [IX_ActionVote_User] ON [dbo].[ActionVote] ([userAccountObjectId])

GO
