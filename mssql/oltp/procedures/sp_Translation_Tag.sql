SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_Translation_Tag] 
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
(select distinct
ufm.organizationObjectId [orgId],t.objectid [tagId],t.name [tagName],t.labelObjectId [localizedStringObjectId],lsv.value,lsv.localeKey
from Tag t (nolock) join PearAnnotationTag pat (nolock) on t.objectId=pat.tagObjectId
join PearModel pm (nolock) on pm.objectId=pat.pearModelObjectId
join UnstructuredFeedbackModel ufm (nolock) on ufm.pearModelObjectId=pm.objectId	
join LocalizedStringValue lsv (nolock) on (t.labelObjectId=lsv.localizedStringObjectId)
where t.organizationObjectId is null
and ufm.organizationObjectId='+cast(@orgId as varchar(100))+'
) t											
PIVOT (											
	MAX(value) FOR localeKey										
	IN (										
		'+@langs+'									
	)										
) AS pvt
order by pvt.tagName';		
				
				
								
EXEC sp_executesql @query;

    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
