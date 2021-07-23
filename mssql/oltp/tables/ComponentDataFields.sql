CREATE TABLE [dbo].[ComponentDataFields] (
   [componentID] [int] NOT NULL,
   [dataFieldID] [int] NOT NULL,
   [sequence] [int] NULL

   ,CONSTRAINT [PK_ComponentDataFields] PRIMARY KEY CLUSTERED ([componentID], [dataFieldID])
)


GO
