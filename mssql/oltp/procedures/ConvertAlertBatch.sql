SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure ConvertAlertBatch
as begin
	create table #AlertConversionBatch (
		sraId int not null,
		orgId int not null
		primary key (sraId, orgId)
	)

	insert into #AlertConversionBatch (sraId, orgId)
	select top 1000 sraId, orgId		-- BATCHSIZE
	from _AlertConversionQueue

	-- Update SurveyResponseAlerts in batch
	update SurveyResponseAlert
	set alertObjectId = _oa.alertId
	from SurveyResponseAlert sra
	join #AlertConversionBatch acb on sra.objectId = sraId
	join _OrgAlerts _oa on acb.orgId = _oa.orgId

	-- Delete batch from queue
	delete from _AlertConversionQueue
	from #AlertConversionBatch b
	join _AlertConversionQueue q on q.sraId = b.sraId and q.orgId = b.orgId

	drop table #AlertConversionBatch
end
return
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
