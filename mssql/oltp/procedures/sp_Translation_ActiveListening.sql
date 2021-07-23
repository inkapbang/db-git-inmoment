SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_Translation_ActiveListening] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	
SET NOCOUNT ON;
DECLARE @query nVARCHAR(4000);											
DECLARE @langs VARCHAR(2000);											
SELECT  @langs = REPLACE(											
					STUFF(			
						( 		
						select '],[' +[language] from (	
						SELECT  [language]
						FROM [_DBA7379] (nolock)				
						) as k		
						ORDER BY '],[' + [language]					
						FOR XML PATH('')	
						), 1, 2, ''		
					) + ']'			
				, '[],','');			
					
											
SET @query = 									
'select * from 
(select t.objectId,t.name [tagName],pat.annotation,t.smartCommentQuestion as [question]
,case when alq.[language]=0 then ''ARABIC''
      when alq.[language]=1 then ''BULGARIAN''
      when alq.[language]=2 then ''CHINESE TRADITIONAL''
      when alq.[language]=3 then ''CHINESE SIMPLIFIED''
      when alq.[language]=4 then ''CROATIAN''
      when alq.[language]=5 then ''CZECH''
      when alq.[language]=6 then ''DANISH''
      when alq.[language]=7 then ''DUTCH''
      when alq.[language]=8 then ''DUTCH_BELGIUM''
      when alq.[language]=9 then ''ENGLISH''
      when alq.[language]=10 then ''FINNISH''
      when alq.[language]=11 then ''FRENCH''
      when alq.[language]=12 then ''FRENCH CANADA''
      when alq.[language]=13 then ''GERMAN''
      when alq.[language]=14 then ''GREEK''
      when alq.[language]=15 then ''HUNGARIAN''
      when alq.[language]=16 then ''ICELANDIC''
      when alq.[language]=17 then ''ITALIAN''
      when alq.[language]=18 then ''JAPANESE''
      else ''UNKNOWN'' end [language]
,alq.question as value
from PearAnnotationTag  pat (nolock) join Tag t (nolock) on (pat.tagObjectId=t.objectId)
join PearModel pm (nolock) on pm.objectId=pat.pearModelObjectId
join UnstructuredFeedbackModel ufm (nolock) on ufm.pearModelObjectId=pm.objectId	
join ActiveListeningQuestion alq (nolock) on (t.objectId=alq.tagObjectId)
where alq.[language] <20
and t.smartCommentQuestion is not null
group by t.objectId,t.name ,pat.annotation,t.smartCommentQuestion 
,case when alq.[language]=0 then ''ARABIC''
      when alq.[language]=1 then ''BULGARIAN''
      when alq.[language]=2 then ''CHINESE TRADITIONAL''
      when alq.[language]=3 then ''CHINESE SIMPLIFIED''
      when alq.[language]=4 then ''CROATIAN''
      when alq.[language]=5 then ''CZECH''
      when alq.[language]=6 then ''DANISH''
      when alq.[language]=7 then ''DUTCH''
      when alq.[language]=8 then ''DUTCH_BELGIUM''
      when alq.[language]=9 then ''ENGLISH''
      when alq.[language]=10 then ''FINNISH''
      when alq.[language]=11 then ''FRENCH''
      when alq.[language]=12 then ''FRENCH CANADA''
      when alq.[language]=13 then ''GERMAN''
      when alq.[language]=14 then ''GREEK''
      when alq.[language]=15 then ''HUNGARIAN''
      when alq.[language]=16 then ''ICELANDIC''
      when alq.[language]=17 then ''ITALIAN''
      when alq.[language]=18 then ''JAPANESE''
      else ''UNKNOWN'' end 
,alq.question 
) t											
PIVOT (											
	MAX(value) FOR language										
	IN (										
		'+@langs+'									
	)										
) AS pvt
order by pvt.[tagName]';	
							

				
								
EXEC sp_executesql @query;
					
		
								

    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
