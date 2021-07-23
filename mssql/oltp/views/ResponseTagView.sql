SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[ResponseTagView] AS
SELECT distinct
    rt.objectId responseTagObjectId,
        rt.responseObjectId,
        rt.timestamp,
        rt.sourceType,
        rt.userAccountObjectId,
        coalesce(gt.objectId, rt.tagObjectId) tagObjectId,
        coalesce(gt.nameObjectId, t.nameObjectId)  tagNameObjectId,
        coalesce(gt.labelObjectId, t.labelObjectId)   tagLabelObjectId,
        coalesce(AdHocCatMapping.ahtcId,mappedCat.objectId, tc.objectId)  as tagCategoryObjectId,
        coalesce(AdHocCatMapping.ahtcNameObjectId, mappedCat.nameObjectId, tc.nameObjectId)   tagCategoryNameObjectId,
        coalesce(AdHocCatMapping.ahtcLabelObjectId,mappedCat.labelObjectId, tc.labelObjectId)   tagCategoryLabelObjectId
    FROM
        ResponseTag rt
        JOIN Tag t
            ON t.objectId = rt.tagObjectId
        LEFT OUTER JOIN TagCategory tc
            ON tc.objectId = t.tagCategoryObjectId
        LEFT OUTER JOIN TagGlobalMapping tgm
            ON t.objectId = tgm.orgTagObjectId
            AND tgm.inUse=1
        LEFT OUTER JOIN Tag gt
           ON tgm.globalTagObjectId = gt.objectId
        LEFT OUTER JOIN TagCategoryGlobalMapping tcgm
			ON tc.objectId = tcgm.orgTagCategoryObjectId
        LEFT OUTER JOIN PearModel pm
		   ON rt.pearModelObjectId=pm.objectid 
        LEFT OUTER JOIN (
			SELECT pmctm.pearModelObjectId, pmctm.tagCategoryObjectId ,tlhtm.tagObjectId
			FROM PearModelCategoryTagMapping pmctm 
			JOIN TagListHolder tlh
				 ON pmctm.tagListHolderObjectId = tlh.objectId
			JOIN TagListHolderTagMapping tlhtm
				ON tlh.objectId = tlhtm.tagListHolderObjectId 
			) AS TagCatMapping ON TagCatMapping.tagObjectId= COALESCE(gt.objectId,t.objectId) 
			--if rt.pearModelObjectId is null, then don't join on pearModelObjectId
			AND CASE WHEN rt.pearModelObjectId IS NULL AND tagCatMapping.tagCategoryObjectId = tcgm.globalTagCategoryObjectId  THEN 1 
					 WHEN pm.organizationObjectId IS NOT NULL AND tagCatMapping.tagCategoryObjectId = tcgm.globalTagCategoryObjectId  THEN 1
					 WHEN rt.pearModelObjectId IS NOT NULL AND rt.pearModelObjectId =TagCatMapping.pearModelObjectId THEN 1 
					 ELSE 0 
					 END=1
        LEFT OUTER JOIN TagCategory mappedCat
            ON TagCatMapping.tagCategoryObjectId = mappedCat.objectId
        LEFT OUTER JOIN (
			SELECT ahtc.objectId as ahtcId, ahtc.labelObjectId as ahtcLabelObjectId, ahtc.nameObjectId as ahtcNameObjectId, ahtc.adHocUse, pmctm.pearModelObjectId
			FROM PearModelCategoryTagMapping pmctm
			JOIN TagCategory ahtc 
				ON ahtc.objectId = pmctm.tagCategoryObjectId
        ) AS AdHocCatMapping ON rt.pearModelObjectId =AdHocCatMapping.pearModelObjectId AND AdHocCatMapping.adHocUse >0 AND AdHocCatMapping.adHocUse =t.adHocUse
			    WHERE ((rt.tagVersion IS NULL OR rt.tagVersion=1) OR (rt.tagVersion > 1 AND rt.pearSource IN(0,2))) 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
