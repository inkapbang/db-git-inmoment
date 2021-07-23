SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_Translation_ReportName]
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
	(select p.organizationObjectid,lsv3.value [folderName],p.objectId [reportId]
	,lsv.value [reportName],b.name [brand],lsv2.localizedStringObjectId,lsv2.value,lsv2.localeKey
	from Page p (nolock) left join dbo.LocalizedStringValue lsv2 with (nolock) on (p.nameObjectId=lsv2.localizedStringObjectId)
	left join dbo.LocalizedStringValue lsv with (nolock) on (p.nameObjectId=lsv.localizedStringObjectId)
	left join Folder f (nolock) on (p.folderObjectId=f.objectId)
	left join dbo.LocalizedStringValue lsv3 with (nolock) on (f.nameObjectId=lsv3.localizedStringObjectId)
	left join Brand b (nolock) on (p.brandObjectId=b.objectId)
	where  p.organizationObjectid ='+cast(@orgId as varchar(100))+'
	and lsv3.localeKey=''en_US''
	and lsv.localeKey=''en_US''
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
