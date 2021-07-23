CREATE TABLE [dbo].[ContactInfo] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [phone] [varchar](25) NULL,
   [otherPhone] [varchar](25) NULL,
   [fax] [varchar](25) NULL,
   [email] [varchar](100) NULL,
   [version] [int] NOT NULL
       DEFAULT (0)

   ,CONSTRAINT [PK_ContactInfo] PRIMARY KEY CLUSTERED ([objectId])
)


GO
