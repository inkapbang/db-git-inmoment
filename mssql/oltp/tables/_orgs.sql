CREATE TABLE [dbo].[_orgs] (
   [orgId] [int] NOT NULL
      IDENTITY (1,1),
   [orgName] [varchar](100) NOT NULL,
   [countOfAllUsers] [int] NULL,
   [countOfUsersThatLoggedIn] [int] NULL,
   [countOfDisabledUsers] [int] NULL,
   [countOfUsersThatDidNotLogIn] AS ([countOfAllUsers]-(isnull([countOfUsersThatLoggedIn],(0))+[countOfDisabledUsers]))
)


GO
