CREATE TABLE [dbo].[activeWarehouses] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [hostname] [varchar](12) NULL,
   [ip] [varchar](12) NULL,
   [isactive] [bit] NULL

   ,CONSTRAINT [PK__activeWa__3213E83F36A662E6] PRIMARY KEY CLUSTERED ([id])
)


GO
