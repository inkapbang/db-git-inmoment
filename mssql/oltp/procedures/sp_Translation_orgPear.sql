SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_Translation_orgPear] 
	-- Add the parameters for the stored procedure here
	@orgId  int, @pearId int
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
p.name,o.name [orgName],ufm.name [unstructuredFeedbackModel]
,t.objectid [tagId],t.name [tagName],t.labelObjectId [localizedStringObjectId],lsv.value,lsv.localeKey
from Pear p (nolock) join PearModel pm (nolock) on (p.objectId=pm.pearObjectId)
join PearAnnotationTag pat (nolock) on (pm.objectId=pat.pearModelObjectId)
join Tag t (nolock) on (t.objectId=pat.tagObjectId )
join UnstructuredFeedbackModel ufm on ufm.pearModelObjectId=pm.objectId	
join organization o (nolock) on (ufm.organizationObjectId=o.objectId)
join LocalizedStringValue lsv (nolock) on (t.labelObjectId=lsv.localizedStringObjectId)
where p.objectId='+cast(@pearId as varchar(100))+'
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
