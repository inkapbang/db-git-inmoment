CREATE TABLE [dbo].[UserAccountRole_LOG] (
   [BASETABLE] [varchar](128) NULL,
   [CHANGETYPE] [varchar](32) NULL,
   [CHANGEUSER] [varchar](64) NULL
       DEFAULT (user_name()),
   [CHANGETIME] [datetime] NULL
       DEFAULT (getdate()),
   [CHANGEID] [int] NOT NULL
      IDENTITY (1,1),
   [CHANGES] [varchar](4000) NULL,
   [userAccountObjectId] [int] NOT NULL,
   [role] [int] NOT NULL

   ,CONSTRAINT [PK__UserAcco__EAE0006C332BA314] PRIMARY KEY CLUSTERED ([CHANGEID])
)


GO
