CREATE TABLE [dbo].[sqljob_history] (
   [id] [bigint] NOT NULL
      IDENTITY (1,1),
   [jobname] [nvarchar](100) NULL,
   [jobstatus] [nvarchar](10) NULL,
   [rundatetime] [datetime] NULL,
   [errormsg] [nvarchar](max) NULL

   ,CONSTRAINT [PK__sqljob_h__3213E83F2B557722] PRIMARY KEY CLUSTERED ([id])
)


GO
