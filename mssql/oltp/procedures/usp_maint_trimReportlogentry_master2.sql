SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure dbo.usp_maint_trimReportlogentry_master2
@startdt datetime,@enddt datetime 
as
declare @currdate datetime
set @currdate=@startdt

while @currdate <=@enddt
begin
	select @currdate
		exec dbo.usp_maint_trimReportlogentry2 @currdate
	set @currdate=dateadd(dd,1,@currdate)
	waitfor delay '00:01:20'
end
return

--EXEC dbo.usp_maint_trimReportlogentry_master2 '12/15/2009','12/31/2009'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
