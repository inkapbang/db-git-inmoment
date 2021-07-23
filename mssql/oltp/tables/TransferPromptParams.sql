CREATE TABLE [dbo].[TransferPromptParams] (
   [promptObjectId] [int] NOT NULL,
   [paramName] [nvarchar](256) NOT NULL,
   [paramValue] [nvarchar](512) NOT NULL

   ,CONSTRAINT [PK_TransferPromptParams] PRIMARY KEY CLUSTERED ([promptObjectId], [paramName])
)


GO
