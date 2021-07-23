CREATE TABLE [dbo].[TermFilter] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [filter] [nvarchar](50) NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_TermFilter] PRIMARY KEY CLUSTERED ([objectId])
)


GO
