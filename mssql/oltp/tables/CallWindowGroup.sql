CREATE TABLE [dbo].[CallWindowGroup] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [name] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_CallWindowGroup] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_CallWindowGroup_by_Organization] ON [dbo].[CallWindowGroup] ([organizationObjectId])

GO
