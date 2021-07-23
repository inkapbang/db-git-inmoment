CREATE TABLE [rli_con].[RadiantUserAccount2_LOG] (
   [RLIBASETABLE] [varchar](128) NULL,
   [RLICHANGETYPE] [varchar](32) NULL,
   [RLICHANGEUSER] [varchar](64) NULL
       DEFAULT (user_name()),
   [RLICHANGETIME] [datetime] NULL
       DEFAULT (getdate()),
   [RLICHANGEID] [int] NOT NULL
      IDENTITY (1,1),
   [RLICHANGES] [varchar](4000) NULL,
   [uid] [varchar](36) NULL,
   [password] [nvarchar](150) NULL,
   [mail] [varchar](100) NULL,
   [legacysegment] [varchar](8000) NULL,
   [givenName] [nvarchar](50) NULL,
   [externalId] [nvarchar](100) NULL,
   [sn] [nvarchar](50) NULL,
   [passwordChangedDate] [datetime] NULL,
   [legacyorganizationid] [nvarchar](4000) NULL,
   [objectId] [int] NULL,
   [loginStatus] [nvarchar](8) NULL,
   [passwordHash] [nvarchar](150) NULL,
   [passwordHistory] [nvarchar](180) NULL,
   [pwdReset] [nvarchar](5) NULL,
   [corporateEmployee] [nvarchar](5) NULL,
   [legacyglobal] [nvarchar](5) NULL,
   [pwdAccountLockedTime] [varchar](20) NULL,
   [legacyrole] [nvarchar](500) NULL,
   [locale] [varchar](25) NULL,
   [timezonename] [varchar](50) NULL

   ,CONSTRAINT [PK__RadiantU__555038DF1348E367] PRIMARY KEY CLUSTERED ([RLICHANGEID])
)


GO
