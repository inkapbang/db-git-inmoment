CREATE TABLE [dbo].[tmpLsvBob] (
   [localizedStringObjectId] [int] NOT NULL,
   [localeKey] [varchar](25) NOT NULL,
   [value] [nvarchar](max) NOT NULL,
   [insertOrder] [bigint] NULL

   ,CONSTRAINT [PK__tmpLsvBo__248AAE3F4C8160C3] PRIMARY KEY CLUSTERED ([localizedStringObjectId], [localeKey])
)


GO
