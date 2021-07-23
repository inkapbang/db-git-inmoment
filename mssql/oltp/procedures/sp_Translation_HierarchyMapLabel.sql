SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE sp_Translation_HierarchyMapLabel
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
	,lsv.localizedStringObjectId
	,lsv.value
	,lsv.localeKey
	from dbo.[Hierarchy] h (nolock) join dbo.ReportHierarchyMap rhm (nolock) on (h.ObjectId=rhm.hierarchyObjectId)
	join LocalizedStringValue lsv (nolock) on (rhm.labelId=lsv.localizedStringObjectId)
	where h.organizationObjectId='+cast(@orgId as varchar(100))+'
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
