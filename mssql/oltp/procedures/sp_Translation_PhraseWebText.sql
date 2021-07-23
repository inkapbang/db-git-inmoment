SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_Translation_PhraseWebText] 
	-- Add the parameters for the stored procedure here
	@orgId  int
AS
BEGIN
	
SET NOCOUNT ON;
DECLARE @query nVARCHAR(4000);											
DECLARE @langs VARCHAR(2000);											

											
SET @query = 									
'select p.organizationObjectId as orgId
,p.name as promptName
,p.webText
,p.objectId as promptObjectId
,ph.objectId [phraseObjectId]
,ao.objectId [audioOptionId]
,ao.name as [language]
,ph.webtext [value]
	from prompt p with (nolock) left join phrase ph (nolock) on (p.objectId=ph.promptobjectId)
	left join AudioOption ao (nolock)ON (ph.audioOptionObjectId = ao.objectId) 
	where p.organizationObjectId='+cast(@orgId as varchar(100))+'	
order by p.objectId ';											
				
				
								
EXEC sp_executesql @query;




    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
