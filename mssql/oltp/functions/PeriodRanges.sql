SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[PeriodRanges] (@organizationId int, @date datetime)
RETURNS TABLE 
AS
RETURN 
(
	select p.objectId,
	 --p.name, 
	p.periodTypeObjectId, pt.type as periodType,
		dbo.GetPeriodBegin(p.objectId, @date) beginDate,
		dbo.getPeriodEnd(p.objectId, @date) endDate
	from Period p
		inner join PeriodType pt on pt.objectId = p.periodTypeObjectId
	where p.organizationobjectid = @organizationId
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
