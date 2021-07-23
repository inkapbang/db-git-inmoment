CREATE TABLE [dbo].[PromptEventActionSegmentType] (
   [promptEventActionObjectId] [int] NOT NULL,
   [segmentTypeObjectId] [int] NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK__PromptEv__9FD0B0EB70EE3C02] PRIMARY KEY CLUSTERED ([promptEventActionObjectId], [segmentTypeObjectId])
)


GO
