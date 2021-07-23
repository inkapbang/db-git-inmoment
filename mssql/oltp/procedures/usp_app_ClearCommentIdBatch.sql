SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_app_ClearCommentIdBatch](
      @beginDate datetime,
      @endDate datetime
) AS
BEGIN
	DELETE FROM CommentIdBatchCommentId
	WHERE batchObjectId IN (
		SELECT objectId FROM CommentIdBatch
		WHERE [timestamp] BETWEEN @beginDate AND @endDate
	)
	DELETE FROM CommentIdBatch
	WHERE [timestamp] BETWEEN @beginDate AND @endDate
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
