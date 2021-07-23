SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create PROCEDURE [dbo].[sp_Translation_DashboardMetricTitle] 
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
(
select tmp.orgId
,tmp.dashboardName
,tmp.widgetName
,lsv.value [title]
,lsv.localizedStringObjectId
,lsv2.value 
,lsv2.localeKey
from
(
select e.titleOverrideId as localizedStringId,d.name as dashboardName,lsv1.value as widgetName
,d.organizationId as orgId
 from ProgramProgressComponentEntry e (nolock)
 --join DataField df (nolock) on e.dataFieldId=df.objectId
 join DashboardComponent c (nolock) on c.objectId=e.dashboardComponentObjectId
 join Dashboard d (nolock) on c.dashboardId=d.objectId
 join LocalizedStringValue lsv1 (nolock) on c.titleId=lsv1.localizedStringObjectId
 where d.organizationId='+cast(@orgId as varchar(5))+'
 and lsv1.localeKey=''en_US'') AS tmp join LocalizedStringValue lsv (nolock) on (tmp.localizedStringId=lsv.localizedStringObjectId)
 join LocalizedStringValue lsv2 (nolock) on (tmp.localizedStringId=lsv2.localizedStringObjectId)
 where lsv.localeKey=''en_US''
 and len(lsv.value)>0
) t											
PIVOT (											
	MAX(value) FOR localeKey										
	IN (										
		'+@langs+'									
	)										
) AS pvt
order by pvt.dashboardName';		
				
				
								
EXEC sp_executesql @query;

    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
