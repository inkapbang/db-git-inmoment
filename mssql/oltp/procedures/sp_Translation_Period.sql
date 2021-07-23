SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_Translation_Period] 
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
(select p.organizationObjectId,lsv.value [periodName],lsv1.localizedStringObjectId,lsv1.value,lsv1.localeKey
from Period p (nolock) join LocalizedStringValue lsv (nolock) on (p.nameObjectId=lsv.localizedStringObjectId)
join LocalizedStringValue lsv1 (nolock) on (p.nameObjectId=lsv1.localizedStringObjectId)
where p.organizationObjectId='+cast(@orgId as varchar(100))+'
and lsv.localeKey=''en_US''
) t											
PIVOT (											
	MAX(value) FOR localeKey										
	IN (										
		'+@langs+'									
	)										
) AS pvt
order by pvt.periodName';
										
				
				
								
EXEC sp_executesql @query;

    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
