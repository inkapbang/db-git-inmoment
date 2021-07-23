CREATE TABLE [dbo].[OOVList] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](30) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_OOVList] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_OOVList_name_org] UNIQUE NONCLUSTERED ([name], [organizationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OOVList_By_Organization] ON [dbo].[OOVList] ([organizationObjectId])

GO
