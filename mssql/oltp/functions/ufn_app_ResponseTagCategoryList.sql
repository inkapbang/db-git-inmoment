SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_ResponseTagCategoryList] (@responseId INT, @localeKey VARCHAR(25) = 'en_US')
RETURNS TABLE
AS
RETURN
 SELECT SUBSTRING(
            (SELECT  ', ' + lst.[value]
    FROM
(SELECT  distinct coalesce(AdHocCatMapping.ahtcLabelObjectId,mappedCat.labelObjectId, tc.labelObjectId) as tagCategoryLabelObjectId
    FROM ResponseTag srt 
	JOIN Tag tag 
		ON tag.objectId = srt.tagObjectId AND srt.responseObjectId=@responseId and (srt.pearSource  !=1 or srt.pearSource is null)
	LEFT OUTER JOIN TagGlobalMapping tgm
		ON tag.objectId = tgm.orgTagObjectId
        AND tgm.inUse=1
    LEFT OUTER JOIN Tag gt
		 ON tgm.globalTagObjectId = gt.objectId
	LEFT OUTER JOIN TagCategory tc
		ON tc.objectId = tag.tagCategoryObjectId
	LEFT OUTER JOIN (
			SELECT pmctm.pearModelObjectId, pmctm.tagCategoryObjectId ,tlhtm.tagObjectId
			FROM PearModelCategoryTagMapping pmctm 
			JOIN TagListHolder tlh
				ON pmctm.tagListHolderObjectId = tlh.objectId
			JOIN TagListHolderTagMapping tlhtm
				ON tlh.objectId = tlhtm.tagListHolderObjectId 
			) AS TagCatMapping ON  srt.pearModelObjectId = TagCatMapping.pearModelObjectId AND TagCatMapping.tagObjectId = COALESCE(tag.objectId,gt.objectId)
	 LEFT OUTER JOIN TagCategory mappedCat
            ON TagCatMapping.tagCategoryObjectId = mappedCat.objectId 
     LEFT OUTER JOIN (
			SELECT  ahtc.labelObjectId as ahtcLabelObjectId, ahtc.adHocUse, pmctm.pearModelObjectId
			FROM PearModelCategoryTagMapping pmctm
			JOIN TagCategory ahtc 
				ON ahtc.objectId = pmctm.tagCategoryObjectId
        ) AS AdHocCatMapping ON AdHocCatMapping.adHocUse >0 AND AdHocCatMapping.adHocUse =tag.adHocUse
) TagCategoryLabels
            CROSS APPLY dbo.ufn_app_LocalizedStringTable(TagCategoryLabels.tagCategoryLabelObjectId, @localeKey) lst 
            ORDER BY
                  lst.[value]
            FOR XML PATH('')
            ), 3, 9999999) AS tagCategoryList
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
