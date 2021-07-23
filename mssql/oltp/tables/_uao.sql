CREATE TABLE [dbo].[_uao] (
   [objectId] [int] NOT NULL,
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
   [exemptFromAutoDisable] [bit] NULL,
   [createdByUserObjectId] [bigint] NULL,
   [temporaryPasswordHash] [nvarchar](150) NULL,
   [uuid] [varchar](36) NOT NULL,
   [xiStatus] [bit] NULL,
   [organizationObjectId] [int] NULL,
   [userAccountObjectId] [int] NULL
)


GO
