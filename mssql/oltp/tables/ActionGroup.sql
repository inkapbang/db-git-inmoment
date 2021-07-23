CREATE TABLE [dbo].[ActionGroup] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [nvarchar](100) NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NULL,
   [organizationObjectId] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_ActionGroup] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ActionGroup_DataField] ON [dbo].[ActionGroup] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_ActionGroup_DataFieldOption] ON [dbo].[ActionGroup] ([dataFieldOptionObjectId])
CREATE NONCLUSTERED INDEX [IX_ActionGroup_Organization] ON [dbo].[ActionGroup] ([organizationObjectId])

GO
