CREATE TABLE [dbo].[FileStore] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [usedMB] [int] NOT NULL,
   [totalMB] [int] NOT NULL

   ,CONSTRAINT [PK_FileStore] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_FileStore_Organization] ON [dbo].[FileStore] ([organizationObjectId])

GO
