CREATE TABLE [dbo].[LocationAttributeGroup] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](50) NULL,
   [description] [varchar](500) NULL,
   [organizationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_LocationAttributeGroup] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_LocationAttributeGroup_Organization] ON [dbo].[LocationAttributeGroup] ([organizationObjectId])

GO
