SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  procedure [dbo].[usp_app_CalcScore]
      (@surveyResponseId int,
      @scoreFieldId int,
      @score float output,
      @answeredCount int = null output,
      @pointsPossible float = null output,
      @answeredPoints float = null output,
      @totalWeight float = null output)
as
BEGIN
	--PRINT 'here'
      declare @scoreType int;
      declare @minPoints float;
      declare @maxPoints float;
 
      with PointsPossible as (
            select c.objectId, max(p.points) pointsPossible
            from DataFieldScoreComponent c
            inner join DataFieldScoreComponentPoints p on p.dataFieldScoreComponentObjectId = c.objectId
            group by c.objectId
      )
      select 
			@answeredCount = count(pts.points),
			@pointsPossible = sum(poss.pointsPossible * comp.weight),
			@answeredPoints = sum(pts.points * comp.weight),
			@minPoints = min(pts.points * comp.weight),
			@maxPoints = max(pts.points * comp.weight),
			@scoreType = max(score.scoreType),
			@totalWeight = sum(comp.weight)
      from
            SurveyResponseAnswer ans
            inner join DataFieldScoreComponent comp on comp.scoredDataFieldObjectId = ans.dataFieldObjectId
            inner join PointsPossible poss on poss.objectId = comp.objectId
            inner join DataFieldScoreComponentPoints pts on pts.dataFieldOptionObjectId = ans.dataFieldOptionObjectId and pts.dataFieldScoreComponentObjectId = comp.objectId
            inner join DataField score on score.objectId = comp.dataFieldObjectId
      where
            ans.surveyResponseObjectId = @surveyResponseId
            and comp.dataFieldObjectId = @scoreFieldId
			and pts.points is not null
      --print cast(@answeredPoints as varchar) + ' points'
 
      select @score = case (@scoreType)
            when 0 then @answeredPoints
            when 1 then case when @pointsPossible > 0.0 then (@answeredPoints / @pointsPossible) * 100.0 else null end
            when 2 then case when (@answeredCount > 0.0) then 
                        case when @totalWeight != 0 then @answeredPoints / @totalWeight else null end
                        end
                  when 3 then @minPoints
                  when 4 then @maxPoints
            else null
            end
      return
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
