SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE sp_Translation_ReportCriteria
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
	(
	select p.organizationObjectId [orgId],lsv.value [folderName]
	,lsv3.value [reportName]
	,lsv2.value [fieldName]
	,lsv1.localizedStringObjectId [criteriaLabelId]
	,lsv1.value 
	,lsv1.localeKey [localeKey]
	from Page p (nolock) join Folder f (nolock) on (p.folderObjectId=f.objectId)
	join LocalizedStringValue lsv3 (nolock) on (p.nameObjectId=lsv3.localizedStringObjectId)
	join LocalizedStringValue lsv (nolock) on (f.nameObjectId=lsv.localizedStringObjectId)
	join PageCriteriaSet pcs (nolock) on (p.objectId=pcs.pageObjectId)
	join PageCriterion pc (nolock) on (pc.objectId=pcs.pageCriterionObjectId)
	join LocalizedStringValue lsv1 (nolock) on (pc.labelObjectId=lsv1.localizedStringObjectId)
	join LocalizedStringValue lsv2 (nolock) on (pc.labelObjectId=lsv2.localizedStringObjectId)
	where p.organizationObjectId='+cast(@orgId as varchar(100))+'
	and lsv.localeKey=''en_US''
	and lsv2.localeKey=''en_US''
	and lsv3.localeKey=''en_US''
	group by p.organizationObjectId
	,lsv.value
	,lsv3.value
	,lsv2.value
	,lsv1.localizedStringObjectId
	,lsv1.value 
	,lsv1.localeKey
	) t											
	PIVOT (											
		MAX(value) FOR localeKey										
		IN (										
			'+@langs+'									
		)										
	) AS pvt
	order by pvt.folderName';											
					
					
									
	EXEC sp_executesql @query;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
