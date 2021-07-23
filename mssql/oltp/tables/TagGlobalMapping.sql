CREATE TABLE [dbo].[TagGlobalMapping] (
   [orgTagObjectId] [int] NOT NULL,
   [globalTagObjectId] [int] NOT NULL,
   [inUse] [int] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_TagGlobalMapping] PRIMARY KEY CLUSTERED ([orgTagObjectId], [globalTagObjectId])
)

CREATE NONCLUSTERED INDEX [IX_TagGlobalMapping_globalTag] ON [dbo].[TagGlobalMapping] ([globalTagObjectId])

GO
