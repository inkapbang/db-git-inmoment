SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_Translation_DashboardName] 
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
(select d.organizationId [organizationObjectid],d.name [dashboardName],lsv.localizedStringObjectId,lsv.value,lsv.localeKey
from Dashboard d (nolock) join LocalizedStringValue lsv (nolock) on (d.labelId=lsv.localizedStringObjectId)
where d.organizationId='+cast(@orgId as varchar(100))+'
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
