CREATE TABLE [dbo].[test] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [fname] [varchar](30) NULL,
   [lname] [varchar](30) NULL,
   [comment] [varchar](200) NULL

   ,CONSTRAINT [PK__test__3213E83F5C37DE77] PRIMARY KEY CLUSTERED ([id])
)


GO
