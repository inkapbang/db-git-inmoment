CREATE TABLE [dbo].[ActionRole] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [labelObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_ActionRole] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ActionRole_Label] ON [dbo].[ActionRole] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_ActionRole_Organization] ON [dbo].[ActionRole] ([organizationObjectId])

GO
