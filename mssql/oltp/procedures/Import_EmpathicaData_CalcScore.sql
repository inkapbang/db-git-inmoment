SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE    procedure [dbo].[Import_EmpathicaData_CalcScore](
@SurveyResponseObjectId int,
@OrgId int
)
as
begin
   
	declare @scoreFieldId int
	declare calcCursor cursor local for
	select df.objectId from DataField df with (nolock)
	where df.organizationObjectId = @OrgId and df.fieldType = 12
	order by df.objectId

    declare @sc float, @count int, @possible float, @totalWt float, @points float
    declare @processedCount int, @insertCount int, @updateCount int, @deleteCount int
    select @updateCount = 0, @insertCount = 0, @deleteCount = 0, @processedCount = 0

	
	open calcCursor
	fetch next from calcCursor into @scoreFieldId
	while @@fetch_status = 0
	begin
		
		select @sc = 0.0,@count = 0,@possible = 0.0, @points = 0.0
		exec usp_app_CalcScore @SurveyResponseObjectId, @scoreFieldId, @score=@sc output, @answeredCount=@count output, @pointsPossible=@possible output, @answeredPoints=@points output, @totalWeight=@totalWt output
        if (@count > 0 and @sc is not null)
		begin
			insert into SurveyResponseScore(surveyResponseObjectId, dataFieldObjectId, score, [count], points, pointsPossible, totalWeight, version)
				values (@SurveyResponseObjectId, @scoreFieldId, @sc, @count, @points, @possible, @totalWt, 0)
		end

		fetch next from calcCursor into @scoreFieldId
	end

	close calcCursor
	deallocate calcCursor


end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
