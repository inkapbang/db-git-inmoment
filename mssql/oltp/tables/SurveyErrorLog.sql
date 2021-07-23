CREATE TABLE [dbo].[SurveyErrorLog] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [errorTimestamp] [datetime] NOT NULL,
   [mode] [int] NULL,
   [host] [varchar](50) NOT NULL,
   [dnisOrAlias] [varchar](25) NULL,
   [gatewayObjectId] [int] NULL,
   [offerCode] [varchar](50) NULL,
   [responseObjectId] [int] NULL,
   [summary] [nvarchar](200) NOT NULL,
   [detail] [nvarchar](max) NULL

   ,CONSTRAINT [PK__SurveyEr__5243E26A01A88EF1] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SurveyErrorLog] ON [dbo].[SurveyErrorLog] ([errorTimestamp], [host], [dnisOrAlias], [gatewayObjectId], [offerCode], [responseObjectId], [summary])

GO
