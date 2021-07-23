SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE Translation_DataFieldOptionLabel 
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
(select d.organizationObjectid,d.objectId as dataFieldId
,d.name as [dataFieldName]
,do.name [dataFieldOptionName]
,lsv.localizedStringObjectId [dataFieldOptionId]
,lsv.value
,lsv.localeKey
from       dbo.DataField d with (nolock) 
           join dbo.DataFieldOption do with (Nolock) on (d.objectId = do.dataFieldObjectId)
           join LocalizedStringValue lsv (nolock) on (do.labelObjectId=localizedStringObjectId)
where  d.organizationObjectid ='+cast(@orgId as varchar(100))+'
) t											
PIVOT (											
	MAX(value) FOR localeKey										
	IN (										
		'+@langs+'									
	)										
) AS pvt
order by pvt.dataFieldName';
										
							
EXEC sp_executesql @query;

    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
