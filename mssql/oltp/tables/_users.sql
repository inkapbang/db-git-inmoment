CREATE TABLE [dbo].[_users] (
   [useraccountobjectid] [int] NOT NULL,
   [email] [varchar](100) NOT NULL,
   [lastName] [nvarchar](50) NOT NULL,
   [firstName] [nvarchar](50) NOT NULL,
   [lastLogin] [datetime] NULL,
   [useraccountEnabled] [bit] NOT NULL,
   [global] [bit] NOT NULL,
   [locationObjectid] [int] NULL,
   [locationName] [nvarchar](100) NULL,
   [organizationObjectId] [int] NULL,
   [locationNumber] [varchar](50) NULL,
   [locationEnabled] [bit] NULL,
   [orgId] [int] NULL,
   [orgName] [varchar](100) NULL,
   [orgEnabled] [bit] NULL
)


GO
