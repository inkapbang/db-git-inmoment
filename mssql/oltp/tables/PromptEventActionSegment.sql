CREATE TABLE [dbo].[PromptEventActionSegment] (
   [promptEventActionId] [int] NOT NULL,
   [segmentObjectId] [int] NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK__PromptEv__6967C7CE25436D94] PRIMARY KEY CLUSTERED ([promptEventActionId], [segmentObjectId])
)


GO
