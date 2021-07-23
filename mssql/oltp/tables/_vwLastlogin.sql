CREATE TABLE [dbo].[_vwLastlogin] (
   [useraccountobjectid] [int] NOT NULL
      IDENTITY (1,1),
   [firstName] [nvarchar](50) NOT NULL,
   [lastName] [nvarchar](50) NOT NULL,
   [email] [varchar](100) NOT NULL,
   [lastlogin] [datetime] NULL,
   [LocationObjectid] [int] NULL,
   [LocationName] [nvarchar](50) NULL,
   [orgid] [int] NULL
)


GO
