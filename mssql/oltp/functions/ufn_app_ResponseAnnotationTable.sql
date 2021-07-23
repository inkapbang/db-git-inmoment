SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_ResponseAnnotationTable] (@responseId INT, @localeKey VARCHAR(25) = 'en_US')
RETURNS @results TABLE (
    annotationId int,
    binaryContentObjectId int,
    offset int,
    [length] int,
    tagList nvarchar(200)
)
as
begin 

    declare @annotations table (
        annotationId int,
        tag nvarchar(50),
        binaryContentObjectId int,
        offset int,
        [length] int
    )

    insert @annotations (annotationId, tag, binaryContentObjectId, offset, [length])
    select distinct
        a.objectId [annotationId],
        list.[value] [tag],
        a.binaryContentObjectId,
        a.offset,
        a.[length]
    from
        Annotation a
        join SurveyResponseAnswer sra on sra.binaryContentObjectId=a.binaryContentObjectId
            and sra.surveyResponseObjectId = @responseId
        join AnnotationTag at on at.annotationObjectId=a.objectId
        join Tag t on t.objectId=at.tagObjectId
        cross apply dbo.ufn_app_LocalizedStringTable(t.nameObjectId, @localeKey ) list 
    order by
        [annotationId], [tag]

    insert @results (annotationId, binaryContentObjectId, offset, [length], tagList)
    select 
        t1.annotationId,
        t1.binaryContentObjectId,
        t1.offset,
        t1.length,
        tagList = substring((select ( ', ' + tag )
                               from @annotations t2
                               where t1.annotationId = t2.annotationId
                               order by annotationId,tag
                               for xml path('')
                              ), 3, 1000 )
    from @annotations t1
    group by t1.annotationId, t1.binaryContentObjectId, t1.offset, t1.length

    return
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
