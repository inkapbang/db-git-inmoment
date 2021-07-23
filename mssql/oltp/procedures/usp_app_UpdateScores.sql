SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE    procedure [dbo].[usp_app_UpdateScores](
      @scoreFieldId int,
      @beginDate datetime,
      @endDate datetime)
as
begin
      declare @scoreType int
      declare @orgId int
      select @scoreType = scoreType, @orgId = organizationObjectId from DataField where objectId = @scoreFieldId
 
      declare responseCursor cursor local for
            select distinct sr.objectid from SurveyResponse sr
                  inner join Survey s on s.objectid = sr.surveyObjectId
            where 
                  s.organizationObjectId = @orgId
                  and sr.beginDate between @beginDate and @endDate
            order by sr.objectid
 
      declare @responseId int, @sc float, @count int, @possible float, @totalWt float, @points float
      declare @processedCount int, @insertCount int, @updateCount int, @deleteCount int
      select @updateCount = 0, @insertCount = 0, @deleteCount = 0, @processedCount = 0
      open responseCursor
 
      fetch next from responseCursor into @responseId
      while @@FETCH_STATUS = 0
      begin
            select @sc = 0.0, @count = 0, @possible = 0.0, @points = 0.0
            exec usp_app_CalcScore @responseId, @scoreFieldId, @score=@sc output, @answeredCount=@count output, @pointsPossible=@possible output, @answeredPoints=@points output, @totalWeight=@totalWt output
            if @count = 0
                  begin
                        delete from SurveyResponseScore
                              where SurveyResponseScore.surveyResponseObjectId = @responseId
                              and SurveyResponseScore.dataFieldObjectId = @scoreFieldId
                        if (@@rowcount > 0)
                        begin
                              set @deleteCount = @deleteCount + 1
                              --print 'deleting score for ' + cast(@responseId as varchar(10))
                        end
                        --else
                              --print 'No scoreable answers or scores found for ' + cast(@responseId as varchar(10))
                  end
            else
                  begin
						if @sc is not null 
						begin
                        update SurveyResponseScore
                              set score = @sc, [count] = @count, points=@points, pointsPossible=@possible, totalWeight=@totalWt
                              where surveyResponseObjectId = @responseId and dataFieldObjectId = @scoreFieldId
						end

                        if @@ROWCOUNT > 0
                              set @updateCount = @updateCount + 1
                        else
                              begin
									if @sc is not null 
									begin
										insert into SurveyResponseScore(surveyResponseObjectId, dataFieldObjectId, score, [count], points, pointsPossible, totalWeight, version)
											values (@responseId, @scoreFieldId, @sc, @count, @points, @possible, @totalWt, 0)
										set @insertCount = @insertCount + 1
									end
                              end
                  end
 
            set @processedCount = @processedCount + 1
            --print 'Processed ' + cast(@processedCount as varchar(10)) + ' responses'
            fetch next from responseCursor into @responseId
      end
 
      close responseCursor
      deallocate responseCursor
 
      print 'Scores created: ' + cast(@insertCount as varchar(10))
      print 'Scores updated: ' + cast(@updateCount as varchar(10))
      print 'Scores deleted: ' + cast(@deleteCount as varchar(10))
 
      select @insertCount insertCount, @updateCount updateCount, @deleteCount deleteCount
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
