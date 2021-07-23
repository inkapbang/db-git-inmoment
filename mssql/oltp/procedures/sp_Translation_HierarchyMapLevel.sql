SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE sp_Translation_HierarchyMapLevel
	-- Add the parameters for the stored procedure here
	@orgId  int
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @query nVARCHAR(4000);											
	DECLARE @langs VARCHAR(2000);											
	SELECT  @langs = REPLACE(											
						STUFF(			
							( 		
							select '],[' +localeKey from (	
							SELECT  localeKey 
							FROM dbo.OrganizationLocale (nolock)
							WHERE 	
								organizationObjectId = @orgId
							union 
							select 'en_US' 
							) as k		
							ORDER BY '],[' + localeKey 				
							FOR XML PATH('')	
							), 1, 2, ''		
						) + ']'			
					, '[],','');			
												
	SET @query = 									
	'select * from 
	(select h.organizationObjectId
	,rhm.name [reportHierarchyMap]
	,lct.name [level]
	,rhml.labelObjectId
	,lsv.value
	,lsv.localeKey
	from dbo.[Hierarchy] h (nolock) join dbo.ReportHierarchyMap rhm (nolock) on (h.ObjectId=rhm.hierarchyObjectId)
	left join dbo.ReportHierarchyMapValue rhmv (nolock) on (rhm.objectId=rhmv.reportHierarchyMapObjectId)
	left join dbo.ReportHierarchyMapLabel rhml (nolock) on (rhmv.reportHierarchyMapObjectId=rhml.reportHierarchyMapObjectId and rhmv.levelObjectId=rhml.levelObjectId)
	join dbo.LocationCategoryType lct (nolock) on (rhmv.levelObjectId=lct.objectId )
	left join dbo.LocalizedStringValue lsv (nolock) on (rhml.labelObjectId=lsv.localizedStringObjectId)
	where h.organizationObjectId='+cast(@orgId as varchar(100))+'
	--and rhml.labelObjectId is not null
	) t											
	PIVOT (											
		MAX(value) FOR localeKey										
		IN (										
			'+@langs+'									
		)										
	) AS pvt
	order by pvt.reportHierarchyMap';
											
					
					
									
	EXEC sp_executesql @query;


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
