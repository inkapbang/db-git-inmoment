CREATE TABLE [dbo].[ActionGroupActionRole] (
   [actionGroupObjectId] [int] NOT NULL,
   [actionRoleObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_ActionGroupActionRole] PRIMARY KEY CLUSTERED ([actionGroupObjectId], [actionRoleObjectId])
)

CREATE NONCLUSTERED INDEX [IX_ActionGroupActionRole_ActionRole] ON [dbo].[ActionGroupActionRole] ([actionRoleObjectId])

GO
