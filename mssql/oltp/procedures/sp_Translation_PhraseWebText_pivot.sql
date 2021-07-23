SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_Translation_PhraseWebText_pivot] 
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
						SELECT DISTINCT	
							'],[' + language
						FROM (select distinct(ao.name) as language
							from prompt p with (nolock) left join phrase ph (nolock) on (p.objectId=ph.promptobjectId)
							left join AudioOption ao (nolock)ON (ph.audioOptionObjectId = ao.objectId) 
							where p.organizationObjectId=@orgId 	
							and ao.name is not null
							) as k
						ORDER BY '],[' + language	
						FOR XML PATH('')	
					), 1, 2, ''		
				) + ']'			
			, '[],','');	


											
SET @query = 									
'SELECT * FROM											
(													
	select p.organizationObjectId as orgId,p.objectId as promptObjectId,p.name as promptName,p.webText
	,ph.objectId [phraseObjectId],ph.webtext [value],ao.name as [language]
	from prompt p with (nolock) left join phrase ph (nolock) on (p.objectId=ph.promptobjectId)
	left join AudioOption ao (nolock)ON (ph.audioOptionObjectId = ao.objectId)  
	where p.organizationObjectId= '+cast(@orgId as varchar(100))+'	
) t											
PIVOT (											
	MAX(value) FOR language										
	IN (										
		'+@langs+'									
	)										
) AS pvt
order by pvt.promptObjectId,pvt.promptName';											
				
				
								
EXEC sp_executesql @query;




    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
