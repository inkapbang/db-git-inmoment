CREATE TABLE [dbo].[tmp_useraccount_passwordReset] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [email] [varchar](100) NOT NULL,
   [lastName] [nvarchar](50) NOT NULL,
   [firstName] [nvarchar](50) NOT NULL,
   [version] [int] NOT NULL,
   [lastLogin] [datetime] NULL,
   [enabled] [bit] NOT NULL,
   [global] [bit] NOT NULL,
   [passwordPolicyOrganizationObjectId] [int] NULL,
   [inboxUserFilter] [int] NOT NULL,
   [localeKey] [varchar](25) NULL,
   [forcePasswordChange] [bit] NOT NULL,
   [timeZone] [varchar](50) NULL,
   [temporaryPassword] [nvarchar](150) NULL,
   [temporaryPasswordExpire] [datetime] NULL,
   [locked] [bit] NOT NULL,
   [lockoutEnd] [datetime] NULL,
   [smsNotificationType] [int] NOT NULL,
   [smsCarrier] [int] NULL,
   [smsNumber] [varchar](50) NULL,
   [smsConfirmationCode] [varchar](10) NULL,
   [smsConfirmed] [bit] NOT NULL,
   [externalId] [nvarchar](100) NULL,
   [mindshareEmployee] [bit] NULL,
   [exemptFromAutoDisable] [bit] NULL
)


GO
