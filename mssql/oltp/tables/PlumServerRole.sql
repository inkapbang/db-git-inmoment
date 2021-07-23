CREATE TABLE [dbo].[PlumServerRole] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [plumServerObjectId] [int] NOT NULL,
   [role] [int] NOT NULL

   ,CONSTRAINT [PK_PlumServerRole] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PlumServerRole_plumServerObjectId] ON [dbo].[PlumServerRole] ([plumServerObjectId])
CREATE NONCLUSTERED INDEX [IX_PlumServerRole_role_PlumServer] ON [dbo].[PlumServerRole] ([role], [plumServerObjectId])

GO
