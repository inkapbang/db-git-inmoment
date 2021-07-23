CREATE TABLE [dbo].[login_history_email_exclusion] (
   [object_id] [int] NOT NULL
      IDENTITY (1,1),
   [org_id] [bigint] NOT NULL,
   [email] [nvarchar](50) NOT NULL

   ,CONSTRAINT [email_exc] PRIMARY KEY CLUSTERED ([org_id], [email])
)


GO
