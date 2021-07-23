CREATE TABLE [dbo].[Folder] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NULL,
   [sequence] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [nameObjectId] [int] NOT NULL,
   [descriptionObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_Folder] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_Folder_Description] UNIQUE NONCLUSTERED ([descriptionObjectId])
   ,CONSTRAINT [UK_Folder_Name] UNIQUE NONCLUSTERED ([nameObjectId])
)

CREATE NONCLUSTERED INDEX [IX_Folder_organizationObjectId] ON [dbo].[Folder] ([organizationObjectId])

GO
