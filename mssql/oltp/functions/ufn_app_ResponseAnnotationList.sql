SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE function [dbo].[ufn_app_ResponseAnnotationList] (@responseId INT, @localeKey VARCHAR(25) = 'en_US')
returns table
as
return
    select substring(
        (select distinct
            ', [' + t.[tagList] + ']'
        FROM
            (select tagList from [dbo].[ufn_app_ResponseAnnotationTable](@responseId, @localeKey)) t
        FOR XML PATH('')
    ), 3, 5000) AS annotationList
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
