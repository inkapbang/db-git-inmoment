SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_maint_updateModifiedResponses]
AS
        declare @currentUpdateTime datetime
        set @currentUpdateTime = (select max(lastModified) from ResponseModified)
        
        IF @currentUpdateTime is not null
        BEGIN
                -- Currently a trigger on SurveyResponse will set the lastModTime to GETUTCDATE() after this update executes
                update sr set lastModTime = @currentUpdateTime
                from SurveyResponse sr
                join (select responseId
                        from ResponseModified
                        where lastModified <= @currentUpdateTime
                        group by responseId
                ) rm
                        on sr.objectId = rm.responseId
                
                delete from ResponseModified where lastModified <= @currentUpdateTime     
                
        END
        
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
