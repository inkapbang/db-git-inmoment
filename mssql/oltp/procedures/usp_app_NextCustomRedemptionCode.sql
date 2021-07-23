SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[usp_app_NextCustomRedemptionCode] (@organizationObjectId int, @market varchar(50),  @redemptionCode varchar(50) OUTPUT,  @endUsableDate datetime OUTPUT)
as
begin
	update top(1) RedemptionCodeCustom with (rowlock)
	set @redemptionCode = redemptionCode, @endUsableDate=usableEndDate, activationDate=getDate()
	where organizationObjectId = @organizationObjectId and market=@market and activationDate is null
	AND (usableStartDate IS null OR usableStartDate <= GETDATE())
	AND (usableEndDate IS null OR usableEndDate >= DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0))
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
