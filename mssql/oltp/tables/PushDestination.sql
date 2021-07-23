CREATE TABLE [dbo].[PushDestination] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [nvarchar](200) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [destinationType] [int] NOT NULL,
   [externalDestinationId] [varchar](200) NOT NULL,
   [enabled] [bit] NOT NULL,
   [username] [nvarchar](max) NULL,
   [password] [nvarchar](max) NULL,
   [clientId] [nvarchar](max) NULL,
   [clientSecret] [nvarchar](max) NULL,
   [tokenRequestURL] [nvarchar](max) NULL,
   [userSecurityToken] [nvarchar](max) NULL,
   [ftpProfileObjectId] [int] NULL,
   [filePath] [varchar](200) NULL,
   [paused] [bit] NOT NULL,
   [lastModified] [datetime] NOT NULL,
   [testEnvironmentKey] [nvarchar](200) NULL,
   [transmitVerboseData] [bit] NULL
      CONSTRAINT [DF_PushDestination_transmitVerboseData] DEFAULT ((0)),
   [zipDataFiles] [bit] NULL
      CONSTRAINT [DF_PushDestination_zipDataFiles] DEFAULT ((1)),
   [technicalContact] [nvarchar](100) NULL

   ,CONSTRAINT [PK_PushDestination] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PushDestination_FtpProfile] ON [dbo].[PushDestination] ([ftpProfileObjectId])
CREATE NONCLUSTERED INDEX [IX_PushDestination_Organization] ON [dbo].[PushDestination] ([organizationObjectId])

GO
