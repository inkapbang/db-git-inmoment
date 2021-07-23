SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_Translation_DataFieldReportText_SystemField]

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
							FROM dbo.Locale (nolock)
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
	(select d.organizationObjectId [orgId],d.objectId [dataFieldObjectId],d.name [dataFieldName]
	,lsv.localizedStringObjectId [dataFieldTextObjectId]
	,lsv.value
	,lsv.localeKey
	from DataField d (nolock) left join LocalizedStringValue lsv (nolock) on (d.textObjectId=localizedStringObjectId)
	where d.systemField=1
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
