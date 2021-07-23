CREATE TABLE [dbo].[ContestRulesConfig] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](100) NOT NULL,
   [version] [int] NOT NULL,
   [linkText] [nvarchar](255) NULL,
   [clientName] [nvarchar](255) NOT NULL,
   [url] [varchar](255) NULL,
   [phoneNumber] [varchar](25) NULL,
   [customSweepstakesText] [nvarchar](1000) NULL,
   [organizationObjectId] [int] NOT NULL,
   [clientId] [int] NULL,
   [surveyId] [int] NULL,
   [sponsoredBy] [int] NULL

   ,CONSTRAINT [PK_ContestRulesConfig] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ContestRulesConfig_organizationObjectId] ON [dbo].[ContestRulesConfig] ([organizationObjectId])

GO
