CREATE TABLE [dbo].[ActionActionRole] (
   [actionObjectId] [int] NOT NULL,
   [actionRoleObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_ActionActionRole] PRIMARY KEY CLUSTERED ([actionObjectId], [actionRoleObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ActionActionRole_ActionRole] ON [dbo].[ActionActionRole] ([actionRoleObjectId])

GO
