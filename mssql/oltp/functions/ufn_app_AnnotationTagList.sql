SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_AnnotationTagList]  (@annotationId INT, @localeKey VARCHAR(25) = 'en_US')    

RETURNS NVARCHAR(3000)    

AS    

BEGIN    

                DECLARE @value NVARCHAR(3000)    

                SELECT @value = SUBSTRING(    

                                (SELECT DISTINCT    

                                                ', ' +  list.[value]    

                                FROM    

                                                AnnotationTag  at    

                                                join Tag t    

                                                                on  t.objectId=at.tagObjectId    

                                                                and  at.annotationObjectId = @annotationId    

                                                CROSS APPLY  dbo.ufn_app_LocalizedStringTable(t.nameObjectId, @localeKey) list     

                                ORDER BY    

                                                ', ' +  list.[value]    

                                FOR XML PATH('')), 3,  9999999)     

                RETURN @value    

END    

     
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
