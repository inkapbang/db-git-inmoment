SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_app_DeleteCommentTerms](
      @commentId INT
      ) AS 
      BEGIN 
      
      delete from CommentTerm where commentId = @commentId
	  	  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
