SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create proc [dbo].[usp_app_GetSentimentRanges] (@commentId int)
as
	select ct.beginOffset, ct.endOffset, ct.sentiment, ct.evidence
	from CommentTerm ct
	join TempComment tc on ct.commentId = tc.objectId
	join SurveyResponseAnswer sra on tc.surveyResponseAnswerObjectId = sra.objectId
	where sra.binaryContentObjectId = @commentId
		and ct.sentiment is not null
		and ct.evidence is not null
	order by beginOffset asc, endOffset asc
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
