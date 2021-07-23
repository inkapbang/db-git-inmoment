CREATE TABLE [Monitor].[EWS_365Day_UserLogin_Results] (
   [OrganizationObjectId] [int] NOT NULL,
   [OrgName] [varchar](100) NOT NULL,
   [Date] [date] NULL,
   [UniqueLogins] [int] NOT NULL,
   [AccessLogins] [int] NOT NULL,
   [Logins/Users] [decimal](10,2) NULL
)


GO
