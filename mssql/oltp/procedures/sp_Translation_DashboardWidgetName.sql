SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create PROCEDURE [dbo].[sp_Translation_DashboardWidgetName] 
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
(select d.organizationId [organizationObjectid],d.name [dashboardName],lsv.value [widgetName]
,lsv2.localizedStringObjectId,lsv2.value,lsv2.localeKey
from Dashboard d (nolock) join DashboardComponent dc (nolock) on (d.objectId=dc.dashboardId)
join LocalizedStringValue lsv (nolock) on (dc.titleId=lsv.localizedStringObjectId)
join LocalizedStringValue lsv2 (nolock) on (dc.titleId=lsv2.localizedStringObjectId)
join LocalizedStringValue lsv3 (nolock) on (d.labelId=lsv3.localizedStringObjectId)
where lsv.localeKey=''en_US''
and d.organizationId='+cast(@orgId as varchar(100))+'
and lsv3.localeKey=''en_US''
and len(lsv.value) >0
) t											
PIVOT (											
	MAX(value) FOR localeKey										
	IN (										
		'+@langs+'									
	)										
) AS pvt
order by pvt.widgetName';		
				
				
								
EXEC sp_executesql @query;

    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
