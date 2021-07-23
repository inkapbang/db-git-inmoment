CREATE TABLE [dbo].[PageCriterionTagTranscriptionConfidenceLevel] (
   [pageCriterionObjectId] [int] NOT NULL,
   [tagTranscriptionConfidenceLevel] [tinyint] NOT NULL

   ,CONSTRAINT [PK_PageCriterionTagTranscriptionConfidenceLevel] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [tagTranscriptionConfidenceLevel])
)


GO
