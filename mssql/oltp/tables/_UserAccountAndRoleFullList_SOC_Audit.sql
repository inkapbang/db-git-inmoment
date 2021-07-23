CREATE TABLE [dbo].[_UserAccountAndRoleFullList_SOC_Audit] (
   [LastName] [nvarchar](50) NOT NULL,
   [FirstName] [nvarchar](50) NOT NULL,
   [OrganizationObjectid] [int] NULL,
   [OrganizationName] [varchar](100) NULL,
   [Email] [varchar](100) NOT NULL,
   [LastLogin] [datetime] NULL,
   [Role] [int] NOT NULL,
   [Role Description] [varchar](36) NULL,
   [Enabled] [bit] NOT NULL,
   [Global] [bit] NOT NULL,
   [InMomentEmployee] [bit] NULL,
   [Locked] [bit] NOT NULL,
   [PasswordPolicyOrg] [varchar](100) NULL
)


GO
