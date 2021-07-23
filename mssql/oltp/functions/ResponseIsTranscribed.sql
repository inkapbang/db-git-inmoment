SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--------------------------

CREATE function [dbo].[ResponseIsTranscribed](@responseId int)
returns bit
as
begin
	return (
		select 
			case 
				when count(*) = 0 then null
				when sum(
					case 
						when Comment.commentText is not null and Comment.transcriptionState > 0 then 1 else 0 
					end
				) > 0 then 1 else 0 
			end
		from Comment
		inner join SurveyResponseAnswer sra
			on Comment.surveyResponseAnswerObjectId = sra.objectId
		WHERE 
			sra.surveyResponseObjectId = @responseId
	)
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
