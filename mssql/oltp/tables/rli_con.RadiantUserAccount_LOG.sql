CREATE TABLE [rli_con].[RadiantUserAccount_LOG] (
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
   [email] [varchar](100) NULL,
   [legacysegment] [varchar](8000) NULL,
   [firstName] [nvarchar](50) NULL,
   [externalId] [nvarchar](100) NULL,
   [lastName] [nvarchar](50) NULL,
   [passwordChangedDate] [datetime] NULL,
   [legacyorganizationid] [int] NULL,
   [objectId] [int] NULL,
   [enabled] [bit] NULL,
   [passwordHash] [nvarchar](150) NULL,
   [passwordHistory] [nvarchar](180) NULL

   ,CONSTRAINT [PK__RadiantU__555038DF11C9E3F2] PRIMARY KEY CLUSTERED ([RLICHANGEID])
)


GO
