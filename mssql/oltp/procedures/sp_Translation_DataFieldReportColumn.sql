SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE Translation_DataFieldReportColumn
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
	(select p.organizationObjectid,lsv3.value [folderName],lsv2.value [reportName]
	--,d.objectId as dataFieldId
	,d.name as [dataFieldName]
	,lsv.localizedStringObjectId [reportColumnLabelId],lsv.value 
	,lsv.localeKey 
	from ReportColumn rc with (nolock) left join dbo.DataField d with (nolock) on (d.objectId=rc.DataFieldObjectId)
	left join dbo.LocalizedStringValue lsv with (nolock) on (rc.labelObjectId=lsv.localizedStringObjectId)
	left join page p with (nolock) on (rc.pageObjectId=p.ObjectId)
	left join folder f (nolock) on (p.folderObjectId=f.objectId)
	left join dbo.LocalizedStringValue lsv2 with (nolock) on (p.nameObjectId=lsv2.localizedStringObjectId)
	left join dbo.LocalizedStringValue lsv3 with (nolock) on (f.nameObjectId=lsv3.localizedStringObjectId) 
	where  p.organizationObjectid ='+cast(@orgId as varchar(100))+'
	and d.systemField =1
	and lsv2.localeKey=''en_US''
	and lsv3.localeKey=''en_US''
	union all
	select p.organizationObjectid,lsv3.value [folderName],lsv2.value [reportName]
	--,d.objectId as dataFieldId
	,d.name as [dataFieldName]
	,lsv.localizedStringObjectId [reportColumnLabelId],lsv.value 
	,lsv.localeKey 
	from ReportColumn rc with (nolock) left join dbo.DataField d with (nolock) on (d.objectId=rc.DataFieldObjectId)
	left join dbo.LocalizedStringValue lsv with (nolock) on (rc.labelObjectId=lsv.localizedStringObjectId)
	left join page p with (nolock) on (rc.pageObjectId=p.ObjectId)
	left join folder f (nolock) on (p.folderObjectId=f.objectId)
	left join dbo.LocalizedStringValue lsv2 with (nolock) on (p.nameObjectId=lsv2.localizedStringObjectId)
	left join dbo.LocalizedStringValue lsv3 with (nolock) on (f.nameObjectId=lsv3.localizedStringObjectId)
	where  p.organizationObjectid ='+cast(@orgId as varchar(100))+'
	and lsv2.localeKey=''en_US''
	and lsv3.localeKey=''en_US''
	group by p.organizationObjectid
	,lsv3.value
	,lsv2.value 
	,d.objectId 
	,d.name 
	,lsv.localizedStringObjectId
	,lsv.value 
	,lsv.localeKey 
	) t					
	PIVOT (											
		MAX(value) FOR localeKey										
		IN (										
			'+@langs+'									
		)										
	) AS pvt
	order by pvt.ReportName';											
					
					
									
	EXEC sp_executesql @query;



    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
