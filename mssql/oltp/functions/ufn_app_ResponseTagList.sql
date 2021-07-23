SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_ResponseTagList] (@responseId INT, @localeKey VARCHAR(25) = 'en_US')
RETURNS TABLE
AS
RETURN
      SELECT SUBSTRING(
            (SELECT
                  ', ' + lst.[value]
            FROM
                  Tag t
                  JOIN ResponseTag srt
                        ON t.objectId = srt.tagObjectId
                        AND srt.responseObjectId = @responseId AND (srt.pearSource  !=1 or srt.pearSource is null)
                  LEFT OUTER JOIN TagGlobalMapping tgm
						ON t.objectId = tgm.orgTagObjectId
            			AND tgm.inUse=1
				  LEFT OUTER JOIN Tag gt
						ON tgm.globalTagObjectId = gt.objectId
                  CROSS APPLY dbo.ufn_app_LocalizedStringTable(coalesce(gt.labelObjectId, t.labelObjectId), @localeKey) lst 
            ORDER BY
                  lst.[value]
            FOR XML PATH('')
            ), 3, 9999999) AS tagList
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
