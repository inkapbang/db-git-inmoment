SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  PROCEDURE [dbo].[sp_Translation_Tag_noOrg] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @query nVARCHAR(4000);											
DECLARE @langs VARCHAR(2000);											
SELECT  @langs = REPLACE(											
					STUFF(			
						( 		
						select '],[en_US' 
						FOR XML PATH('')	
						), 1, 2, ''		
					) + ']'			
				, '[],','');	
				
select @langs						
											
SET @query = 									
'select * from 
(select distinct
ufm.organizationObjectId [orgId],t.objectid [tagId],t.name [tagName],t.labelObjectId [localizedStringObjectId],lsv.value,lsv.localeKey
from Tag t (nolock) join PearAnnotationTag pat (nolock) on t.objectId=pat.tagObjectId
join PearModel pm on pm.objectId=pat.pearModelObjectId
join UnstructuredFeedbackModel ufm on ufm.pearModelObjectId=pm.objectId	
join LocalizedStringValue lsv (nolock) on (t.labelObjectId=lsv.localizedStringObjectId)
where t.organizationObjectId is null
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
