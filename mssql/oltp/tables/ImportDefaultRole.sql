CREATE TABLE [dbo].[ImportDefaultRole] (
   [importDefaultObjectId] [int] NOT NULL,
   [userRole] [int] NOT NULL

   ,CONSTRAINT [PK_ImportDefaultRole] PRIMARY KEY CLUSTERED ([importDefaultObjectId], [userRole])
)


GO
