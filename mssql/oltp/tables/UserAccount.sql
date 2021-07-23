CREATE TABLE [dbo].[UserAccount] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [email] [varchar](100) NOT NULL,
   [lastName] [nvarchar](50) NOT NULL,
   [firstName] [nvarchar](50) NOT NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [lastLogin] [datetime] NULL,
   [enabled] [bit] NOT NULL,
   [global] [bit] NOT NULL
       DEFAULT ((0)),
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
   [smsConfirmed] [bit] NOT NULL
      CONSTRAINT [DF_UserAccount_smsConfirmed] DEFAULT ((0)),
   [externalId] [nvarchar](100) NULL,
   [mindshareEmployee] [bit] NULL
      CONSTRAINT [DF_UserAccount_mindshareEmployee] DEFAULT ((0)),
   [exemptFromAutoDisable] [bit] NULL
      CONSTRAINT [DF_UserAccount_ExemptFromAutoDisable] DEFAULT ((0)),
   [createdByUserObjectId] [bigint] NULL,
   [temporaryPasswordHash] [nvarchar](150) NULL,
   [uuid] [varchar](36) NOT NULL
      CONSTRAINT [DF_UserAccount_uuid] DEFAULT (lower(CONVERT([varchar](36),newid(),(0)))),
   [xiStatus] [bit] NULL

   ,CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_UserAccount_ExternalID] ON [dbo].[UserAccount] ([externalId])
CREATE NONCLUSTERED INDEX [IX_UserAccount_localeKey] ON [dbo].[UserAccount] ([localeKey])
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserAccount_UniqueEmail] ON [dbo].[UserAccount] ([email]) INCLUDE ([enabled])
CREATE NONCLUSTERED INDEX [IX_UserAccount_uuid] ON [dbo].[UserAccount] ([uuid])
CREATE NONCLUSTERED INDEX [IX_UserAccount_uuid2] ON [dbo].[UserAccount] ([uuid]) INCLUDE ([firstName], [lastName], [email], [externalId], [enabled])

GO
