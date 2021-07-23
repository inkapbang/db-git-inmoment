SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_app_StoreTerm]
(
  @commentId BIGINT ,
  @text NVARCHAR(200) ,
  @wordCount INT ,
  @beginOffset INT ,
  @endOffset INT ,
  @score FLOAT = null,
  @rawSentiment FLOAT = null,
  @evidence INT = null,
  @sentiment INT = null
   
)
AS 
BEGIN 
    DECLARE @termId INT 
	
    SELECT
        @termId = [objectId]
    FROM
        [dbo].[Term]
    WHERE
        [text] = @text
	
    IF ( @termId IS NULL ) 
        BEGIN
            INSERT  INTO [dbo].[Term]
                    ( [text] , [wordCount] )
            VALUES
                    ( @text , @wordCount ) 
			          
            SELECT
                @termId = SCOPE_IDENTITY()
        END 
	
    Declare @dupeCount int
    
    select 
		@dupeCount = count(*)
	from
		CommentTerm
	where 
		commentId = @commentId
		and termId = @termId
		and beginOffset = @beginOffset
		and endOffset = @endOffset
		
	if (@dupeCount < 1)	
    begin
		INSERT  INTO [dbo].[CommentTerm]
				( [commentId] ,
				  [termId] ,
				  [beginOffset] ,
				  [endOffset] ,
				  [score] ,
				  [rawSentiment] ,
				  [evidence] ,
				  [sentiment] )
		VALUES
				( @commentId ,
				  @termId ,
				  @beginOffset ,
				  @endOffset ,
				  @score ,
				  @rawSentiment ,
				  @evidence ,
				  @sentiment )
	end

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
