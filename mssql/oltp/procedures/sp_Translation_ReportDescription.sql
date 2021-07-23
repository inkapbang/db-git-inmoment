SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE sp_Translation_ReportDescription
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
	select f.organizationObjectId [orgId]
	,lsv4.value [folderName],lsv.value [reportName],lsv2.value [description],lsv3.localizedStringObjectId,lsv3.value,lsv3.localeKey
	from Page p (nolock) left join dbo.LocalizedStringValue lsv3 with (nolock) on (p.descriptionObjectId=lsv3.localizedStringObjectId)
	left join dbo.LocalizedStringValue lsv with (nolock) on (p.nameObjectId=lsv.localizedStringObjectId)
	left join dbo.LocalizedStringValue lsv2 with (nolock) on (p.descriptionObjectId=lsv2.localizedStringObjectId)
	left join Folder f (nolock) on (p.folderObjectId=f.objectId)
	left join dbo.LocalizedStringValue lsv4 with (nolock) on (f.nameObjectId=lsv4.localizedStringObjectId)
	where  p.organizationObjectid ='+cast(@orgId as varchar(100))+'
	and lsv.localeKey=''en_US''
	and lsv4.localeKey=''en_US''
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
